```ruby
class ReviewsController < ApplicationController
  def index
    # use the product id from params to find the product of interest, the key of the params hash can always be seen in the dynamic portion of the URI via rake routes
    @product = Product.find(params[:product_id])
    @reviews = @product.reviews
  end

  def new
    @product = Product.find(params[:product_id])
    @review = Review.new
  end

  def create
    @product = Product.find(params[:product_id])
    @review = Review.new(review_params)
    # assign the relationship between the review and product
    @review.product = @product

    if @review.save
      flash[:notice] = "Review saved successfully."
      redirect_to product_path(@product)
    else
      flash[:alert] = "Failed to save review."
      render :new
    end
  end

  def review_params
    params.require(:review).permit(:body)
  end
end
```

```ruby
# alternative syntax for saving the correct product to the review:
class ReviewsController < ApplicationController
  def index
    @product = Product.find(params[:product_id])
    @reviews = @product.reviews
  end

  def new
    @product = Product.find(params[:product_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)

    if @review.save
      flash[:notice] = "Review saved successfully."
      redirect_to product_path(@product)
    else
      flash[:alert] = "Failed to save review."
      render :new
    end
  end

  def review_params
    params.require(:review).permit(:body).merge(product: Product.find(params[:product_id]))
  end
end
```

---

Forms: If a form has its own page, the form\_for will have to have an array that hold both the object for the parent and the child, where the parent was defined as an instance variable in the Review\#new

```ruby
class ReviewsController < ApplicationController
  ...
  def new
    @product = Product.find(params[:product_id])
    @review = Review.new
  end
  ...
end
```

```ruby
<h1>New Review for <%= @product.name %></h1>

<%= form_for [@product, @review] do |f| %>
  <%= f.label :body %>
  <%= f.text_field :body %>

  <%= f.submit %>
<% end %>
```

Simply consider whether or not it will be necessary, for example if the form for a new review was on the product show page, you would not need a nested route (unique URL) for the form, and would instead have:

```ruby
class ProductsController < ApplicationController
  ...
  def show
    @product = Product.find(params[:id])
    @review = Review.new
  end
  ...
end
```

```ruby
# products/show.html.erb
<h1>New Review for <%= @product.name %></h1>

<%= form_for [@product, @review] do |f| %>
  <%= f.label :body %>
  <%= f.text_field :body %>

  <%= f.submit %>
<% end %>
# submission will hit Review#create
```

```ruby
class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    if @review.save
      flash[:success] = "Review has been successfully created!"
    else
      flash[:error] = @review.errors.full_messages.join(", ")
    end
    redirect_to post_path(@review.post)
  end
  ...
  private
  def review_params
    params.require(:review).permit(:body).merge(product: Product.find(params[:product_id]))
  end
end 
```

---

Path helpers: keep in mind that with nested routes, for exmaple if you are trying to go to a review show page or rerender a form template if you filled it out incorrectly, you must make sure to define and pass in both the parent and child objects

* rake routes is your best friend
* use `| grep thingofinterest` to filter through routes

```ruby
# example of how to use path helper, pass in the arguments in the correct order of nesting, use URI in rake routes to help inform you
product_review_path(@product, @review)
```

---

don’t forget about `dependents: destroy`, if you don’t, if you try to go to the review index page for example, it might blow up since the product has been deleted, but its reviews haven’t
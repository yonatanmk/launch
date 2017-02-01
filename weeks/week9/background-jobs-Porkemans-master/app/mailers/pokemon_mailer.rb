class PokemonMailer < ApplicationMailer
  def new_email

    mail(
      to: "porkachu24@gmail.com",
      subject: "ITS ALIVE!"
    )
  end
end

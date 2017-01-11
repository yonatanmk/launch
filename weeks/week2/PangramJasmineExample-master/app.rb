require 'sinatra'

def homepage
  <<-HTML
    <!DOCTYPE html>
    <html>
    <head>
      <meta charset="utf-8">
      <title>pangram-facilitation</title>
    </head>
    <body>
      <a href="js/SpecRunner.html">Jasmine Specs</a></br>
      <a href="js/index.html">Index Page</a>
    </body>
    </html>
  HTML
end

get '/' do
  homepage
end

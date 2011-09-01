## Fluent HTML

This class for the Force.com platform aims to provide a robust method of generating HTML from within APEX.

### Why would I want to do such a thing?

There are times that it is necessary to generate HTML from within your APEX code.  And whilst this starts to muddy the boundary between controller and view it is something that we have to accept as possible; if not "textbook" perfect.  

### How does this class help me?

The Fluent HTML class provides you with a code based solutoin to creating HTML rather than having to write the markup out by hand in a string in your class.  When you start to hand code HTML in your calss it is likely that you will forget to close a tag here and there or you may even start to construct illegal HTML.  The Fluent HTML class ensures that the HTML is well formed without you having to worry about it. Note: whilst it is legal within HTML to omit certain closing tags in certain conditions the decision was taken with this class to always close all of the tags to keep the implementation simplistic.

Another benefit of the Fluent HTML class is that it will only allow you to add tags in a legal order - for example you can't create a &lt;tr&gt; without first creating a &lt;table&gt;.

### How do I use this class?

The class implements a [fluent style interface](http://en.wikipedia.org/wiki/Fluent_interface) 

To generate the following HTML:

    <div>
        <a> href="http://www.google.co.uk">Search</a>
    </div>
    
All you need to do in code is:

    new FluentHTML().div().a('http://www.google.co.uk','Search');

It's all fairly intuitive and there are couple more exaples on my [blog](http://smgoodyear.com/2011/06/16/generating-html-from-within-apex/)

### What's still missing?

At the minute the library is very small and only contains the most basic HTML elements.  The first priority for the project is to expand this to include all valid HTML 5 elements.  The next step is to provide overrides for each of the elements to provide shortcuts to set the most commonly used attributes directly from the method rather than having to add an attribute map.

### Who's contributed to this?

So far only I have worked on this project but feel free to fork, join in and see your name in lights just here!

### How's it licensed?

The project is licensed under the [BSD 2 clause license](http://www.opensource.org/licenses/bsd-license.php).
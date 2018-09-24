class PostsController < ApplicationController

    http_basic_authenticate_with name: "chris", password: "1234", except: [:index, :show]

    def index
        # this passes all posts to the index view in @posts
        @posts = Post.all
    end

    def show
        @post = Post.find(params[:id])
    end

    def new
        @post = Post.new
    end

    def create
        # show what data was received in the browser
        # render plain: params[:post].inspect

        @post = Post.new(post_params)
        
        if (@post.save)
            redirect_to @post
        else
            render 'new' 
        end
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        @post = Post.find(params[:id])

        if (@post.update(post_params))
            redirect_to @post
        else
            render 'edit' 
        end
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy

        redirect_to posts_path
    end

    private def post_params
        params.require(:post).permit(:title, :body)
    end

end

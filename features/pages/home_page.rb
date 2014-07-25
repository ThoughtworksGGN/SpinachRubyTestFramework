module Pages
  class Home < Pages::Base
    path '/'

    def comment_author
      source.find('#author')
    end

    def comment_email
      source.find('#email')
    end

    def comment
      source.find('#comment')
    end

    def submit_comment
      source.find('#submit').click
    end

    def fill_comment_name(name)
      comment_author.set(name)
    end

    def fill_comment_email(email)
      comment_email.set(email)
    end

    def fill_comment(commnt)
      comment.set(commnt)
    end

  end
end
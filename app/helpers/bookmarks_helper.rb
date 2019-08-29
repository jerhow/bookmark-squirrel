module BookmarksHelper

  def action_row(showing_archived, b)
    ##
    # This is ugly I know. I was hoping this could have been a partial so I wouldn't have to
    # represent markup as strings. Unfortunately Rails doesn't really give you a good way 
    # to abstract out to a partial from within a loop where you're iterating over data. 
    # It's possible but inefficient, and I would have had to embed conditional logic in
    # the partial anyway. Sometimes you have to just pick something and move forward.
    #
    if showing_archived
      "<a rel='nofollow' data-method='patch' href='/b/#{b.id}/restore' 
        title='Restore this bookmark to your active list'><button 
          id='btn_delete_bm_#{b.id}' class='bm_btn_restore'>Restore</button></a>".html_safe
    else
      (link_to edit_bookmark_path(b) do
        "<button id='btn_edit_bm_#{b.id}' class='bm_btn_edit' 
          title='Edit this bookmark'>&nbsp;Edit&nbsp;</button>".html_safe
      end) +
      "<a rel='nofollow' data-method='patch' href='/b/#{b.id}/archive'
        title='Archive this bookmark'><button id='btn_delete_bm_#{b.id}' 
        class='bm_btn_archive'>Archive</button></a>".html_safe
    end
  end
end

<#if comments?size == 0>
  <div class="nocomment-tip">目前还没有评论</div>
<#else>
  <div class="panel panel-default">
    <div class="panel-heading">共 ${comments?size} 条评论</div>
    <div class="panel-body">
      <#list comments as comment>
        <div class="media" id="comment${comment.id}" style="padding-left: ${comment.layer * 30 + 15}px;">
          <div class="media-body">
            <div class="media-heading gray">
              <a href="/user/${comment.username}"><img src="${comment.avatar}" class="avatar avatar-sm" alt=""/></a>
              <a href="/user/${comment.username!}">${comment.username!} </a>
              <#if topicUser?? && topicUser.id == comment.userId>
                <span class="text-success">[楼主]</span>
              </#if>
              ${model.formatDate(comment.in_time)}
              <span class="pull-right">
              <i id="vote_icon_${comment.id}" class="fa fa-chevron-up
                <#if model.getUpIds(comment.up_ids)?seq_contains('${_user.id}')> fa-thumbs-up <#else> fa-thumbs-o-up </#if>"
                 onclick="vote('${comment.id}')"></i>
              <#if _user??>
                <span id="vote_count_${comment.id}">${model.getUpIds(comment.up_ids)?size}</span>
                <#if _user.id == comment.userId>
                  <a href="/comment/edit/${comment.id}"><span class="glyphicon glyphicon-edit"></span></a>
                  <a href="javascript:;" onclick="deleteComment(${comment.id})"><span
                      class="glyphicon glyphicon-trash"></span></a>
                </#if>
                <a href="javascript:commentThis('${comment.username}', '${comment.id}');"><span
                    class="glyphicon glyphicon-comment"></span></a>
              </#if>
              </span>
            </div>
            <div class="comment-detail-content clearfix">${model.formatContent(comment.content)}</div>
          </div>
        </div>
        <#if comment?has_next>
          <div class="divide"></div>
        </#if>
      </#list>
      <script>
        function vote(id) {
          $.get("/api/comment/vote?id=" + id, function (data) {
            if (data.code === 200) {
              var voteIcon = $("#vote_icon_" + id);
              if (voteIcon.hasClass("fa-thumbs-up")) {
                toast("取消点赞成功", "success");
                voteIcon.removeClass("fa-thumbs-up");
                voteIcon.addClass("fa-thumbs-o-up");
              } else {
                toast("点赞成功", "success");
                voteIcon.addClass("fa-thumbs-up");
                voteIcon.removeClass("fa-thumbs-o-up");
              }
              $("#vote_count_" + id).text(data.detail);
            } else {
              toast(data.description);
            }
          })
        }
      </script>
    </div>
  </div>
</#if>

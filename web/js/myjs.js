function doLike(pid, uid) {
    const d = {
        uid: uid,
        pid: pid,
        operation: 'like'
    };

    $.ajax({
        url: 'LikeServlet',
        data: d,
        success: function (data, textStatus, jqXHR) {
            if (data.trim() === 'true') {
                let c = $(".like-counter").html();
                c++;
                $(".like-counter").html(c);
                $("#like-button").removeClass("fa-thumbs-o-up");
                $("#like-button").addClass("fa-thumbs-up");
            }
            else if(data.trim() === 'delete'){
                let c = $(".like-counter").html();
                c--;
                $(".like-counter").html(c);
                $("#like-button").addClass("fa-thumbs-o-up");
                $("#like-button").removeClass("fa-thumbs-up");
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(jqXHR);
        }
    });
}
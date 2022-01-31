<script>
	export let PostInfo;
</script>


<div class="card">
    <br>
    <div class="content">{@html PostInfo.content}</div>
    <div class="card__footer level content px-2">{PostInfo.author}  ({PostInfo.at})</div>
    <div class="card__action-bar u-center">
	<button class="btn-transparent outline like"><i class="fa-wrapper fa fa-heart"></i> {PostInfo.likes}</button>
	<!--<button class="btn-transparent outline comments"><i class="fa-wrapper fa fa-comments"></i></button>-->
	<!--<button class="btn-transparent outline tip"><i class="fa-wrapper fa fa-dollar-sign"></i></button>-->
    </div>
</div>


<style>
   .card {
        background-color: rgba(255, 255, 255, 0.8);
	text-align: left;
    }
    .card:hover {
        transition: 0.4s;
        background-color: #fff;
    }
    .like:hover {
        color: #f00;
    }
</style>

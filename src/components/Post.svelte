<script>
	let Post = {
		content: "A quick brown fox jumps over the lazy dog.",
		timestamp: "31st of Jan, Mon 12:32 PM"
		}
</script>


<div class="card">
    <br>
    <div class="content">{Post.content}</div>
    <div class="card__footer level content px-2">{Post.timestamp}</div>
    <div class="card__action-bar u-center">
        <button class="btn-transparent outline like"><i class="fa-wrapper fa fa-heart"></i></button>
        <button class="btn-transparent outline comments"><i class="fa-wrapper fa fa-comments"></i></button>
        <button class="btn-transparent outline tip"><i class="fa-wrapper fa fa-dollar-sign"></i></button>
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

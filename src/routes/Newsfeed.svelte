<script>
	let token = localStorage.token;
	export var Posts = [];

	import { onMount } from 'svelte';
	import Post from '@/components/Post.svelte';

	function clear() {
		document.querySelector('textarea').value = '';
	}

	function post() {
		let sd = new showdown.Converter();
		let content = document.querySelector('textarea').value;
		if (content) {
			content = sd.makeHtml(content);
			fetch('http://127.0.0.1:8888/post', {
				method: "PUT",
				headers: {"Content-Type": "application/json", "token": token},
				body: JSON.stringify({content: content})
			})
			.then(resp => resp.json())
			.then(data => {
				if (data['resp'] === 'done') {
					document.location = '/';
				}
			})
			.catch(err => {console.error(err)})
		}
	}

	function get_posts() {
		fetch('http://127.0.0.1:8888/posts', {
			method: "GET",
			headers: {"token": token}
		})
		.then(resp => resp.json())
		.then(data => { Posts = data['posts'] })
		.catch(err => {console.error(err)})
	}


	onMount( get_posts );
</script>


<section class="section">
  <div class="hero">
    <div class="hero-body">
      <div class="content hero_content">
<div class="card">
    <br>
    <div class="content"><textarea placeholder="What's there running on your mind?"></textarea></div>
    <div class="card__action-bar u-center">
	<button class="btn-transparent outline post" on:click={post}><i class="fa-wrapper fa fa-paper-plane"></i></button>
	<button class="btn-transparent outline clear" on:click={clear}><i class="fa-wrapper fa fa-times"></i></button>
    </div>
</div>
{#each Posts.reverse() as PostInfo}
	<Post {PostInfo} />
{/each}
      </div>
    </div>
  </div>
</section>


<style>
.section {
	padding-top: 1em;
}
</style>

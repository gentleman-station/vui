<script>
	let authenticated = false;
	import { link } from "svelte-routing";
	import { navigate } from "svelte-routing";

	if ('token' in localStorage) {
		authenticated = true;
	}
</script>

<div class="header header-fixed unselectable header-animated bg-dark">
   <div class="header-brand">
      <div class="nav-item no-hover">
         <h6 class="title"><a class="text-red-600" use:link replace href="/">vUI</a></h6>
      </div>
      <div class="nav-item nav-btn" id="header-btn"> <span></span> <span></span> <span></span> </div>
   </div>
   <div class="header-nav" id="header-menu">
      <div class="nav-left">
	<div class="nav-item text-center">
                <a href="https://is.gd/c_nick" target="_blank">
                    <span class="icon">
                        <i class="fab fa-wrapper fa-github text-red-600" aria-hidden="true"></i>
                    </span>
                </a>
            </div>
	<div class="nav-item text-center">
                <a href="https://twitter.com/naryal2580" target="_blank">
                    <span class="icon">
                        <i class="fab fa-wrapper fa-twitter text-red-600" aria-hidden="true"></i>
                    </span>
                </a>
            </div>
      </div>
      <div class="nav-right">
         <div class="nav-item has-sub toggle-hover" id="dropdown">
            <a class="nav-dropdown-link text-red-600">Menu</a> 
            <ul class="dropdown-menu dropdown-animated" role="menu">
               <li role="menu-item"><a use:link replace href="/">Home</a></li>
	       {#if authenticated}
		<li role="menu-item"><a on:click="{() => {localStorage.clear()}}" href="/">Logout</a></li>
	       {:else}
	       <li role="menu-item"><a use:link replace href="/auth">Login/Register</a></li>
	       {/if}
            </ul>
         </div>
      </div>
   </div>
</div>

<script>
  import Router from "svelte-routing/Router.svelte";
  import Route from "svelte-routing/Route.svelte";
  import Link from "svelte-routing/Link.svelte";

  import Navbar from "@/components/Navbar.svelte"
  import Home from "@/routes/Home.svelte";
  import AuthPage from "@/routes/AuthPage.svelte";

  export let url = "";
</script>

<Navbar />
<main class="container">
  <Router {url}>
    <div>
      <Route path="/"><Home /></Route>
      <Route path="auth" component="{AuthPage}" />
    </div>
  </Router>
</main>

<style>
  main {
    text-align: center;
    padding: 1em;
    max-width: 240px;
    margin: 0 auto;
  }

  @media (min-width: 640px) {
    main {
      max-width: none;
    }
  }
</style>

<script lang="ts">
  import IcecastMetadataPlayer from "icecast-metadata-player";
  import SpinnerIcon from "@/components/SpinnerIcon.svelte";

  let metadata: any = null;
  let button = "▶";

  const player = new IcecastMetadataPlayer("https://kute.pona.la/stream/tpr", {
    metadataTypes: ["ogg"],
    onMetadata: (meta: any) => {
      metadata = meta;
    },
    onLoad: () => {
      button = "Loading";
    },
    onPlay: () => {
      button = "■";
    },
    onStop: () => {
      button = "▶";
      metadata = null;
    },
  });
  const buttonHandler = () => {
    switch (player.state) {
      case "loading":
      case "stopping":
      case "playing":
        player.stop();
        break;
      default:
        player.play();
    }
  };
</script>

<div>
  <button id="button" class="button" on:click={buttonHandler}>
    {#if button == "Loading"}
      <SpinnerIcon></SpinnerIcon>
    {:else}
      <span class="button-text">{button}</span>
    {/if}
  </button>
  <span>
    {!metadata
      ? button == "Loading"
        ? "Loading the audio stream..."
        : "Click play!"
      : `${metadata.ARTIST} — ${metadata.TITLE}`}
  </span>
</div>

<style>
  div {
    padding: 15px;
    background-color: var(--bg-1);
    border-radius: 15px;
    font-size: 120%;
    text-align: unset;
    display: flex;
    align-items: center;
    gap: 20px;
  }
  button {
    background-color: var(--bg-3);
    width: 80px;
    height: 60px;
    text-align: center;
    font-size: 35px;
    padding: 10px;
    border-radius: 10px;
    border: 2px solid var(--grey);
  }
  button:hover {
    border-color: var(--accent);
  }
  .button-text {
    display: block;
    transform: translate(0, -10px);
  }
</style>

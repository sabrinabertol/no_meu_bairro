const showMap = () => {
  const mapElement = document.getElementById('map');
  const listElement = document.getElementById('list-services');
  const mapButton = document.getElementById('map-button');
  if (mapButton) {
    mapButton.addEventListener('click', () => {
      mapElement.classList.remove("d-none");
      listElement.classList.add("d-none");
      console.log("showmap");
    });
  }
};

export { showMap };

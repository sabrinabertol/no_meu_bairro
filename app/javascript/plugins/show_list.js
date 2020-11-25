const showList = () => {
  const listElement = document.getElementById('list-services');
  const mapElement = document.getElementById('map');
  const listButton = document.getElementById('list-button');
  if (listButton) {
    listButton.addEventListener('click', () => {
      listElement.classList.remove("d-none");
      mapElement.classList.add("d-none");
      console.log("showlist");
    });
  }
};


export { showList };

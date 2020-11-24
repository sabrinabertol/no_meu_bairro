const previewImageOnFileSelect = () => {
  // we select the photo input
  const input = document.getElementById('photo-input');
  console.log(input)
  if (input) {
    console.log("teste")
    // we add a listener to know when a new picture is uploaded
    input.addEventListener('change', () => {
      // we call the displayPreview function (who retrieve the image url and display it)
      console.log("chamando display preview")
      displayPreview(input);
    })
  }
}

const displayPreview = (input) => {
    debugger;
  if (input.files && input.files[0]) {
    console.log("1")
    const reader = new FileReader();
    reader.onload = (event) => {
      console.log("2")
      document.getElementById('photo-preview').src = event.currentTarget.result;
    }
    reader.readAsDataURL(input.files[0])
    document.getElementById('photo-preview').classList.remove('hidden');
  }
}

export { previewImageOnFileSelect };

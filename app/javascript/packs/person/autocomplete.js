import axios from 'axios';
const idAutocomplete = '#builder_promise_form_name';
const lastName = '#builder_promise_form_last_name';
const ci = '#builder_promise_form_ci';
const phone = '#builder_promise_form_phone';
const classAutocompleteList = '.autocompleteList';
const idPerson = '#builder_promise_form_id';
$(document).ready(() => {
  new autoComplete({
    data: {                              // Data src [Array, Function, Async] | (REQUIRED)
      src: async () => {
        const query = document.querySelector(idAutocomplete).value;
        $(idPerson).val('');
        // Fetch External Data Source
        const source = await axios.get('/api/v1/search',{params:{query}});
        if(source.status === 200){
          const {data} = source;
          if(data.type === 'SUCCESSFULLY'){
            return data.payload
          }
        }
        return []
      },
      key: ["phone", "ci", "full_name"],
      cache: false
    },
    placeHolder: "Escribe el nombre",     // Place Holder text                 | (Optional)
    selector: idAutocomplete,           // Input field selector              | (Optional)
    threshold: 3,                        // Min. Chars length to start Engine | (Optional)
    debounce: 300,                       // Post duration for engine to start | (Optional)
    searchEngine: "loose",              // Search Engine type/mode           | (Optional)
    resultsList: {                       // Rendered results list object      | (Optional)
      render: true,
      container: source => {
        source.setAttribute("class", classAutocompleteList.replace('.', ''));
      },
      destination: document.querySelector(idAutocomplete),
      position: "afterend",
      element: "ul"
    },
    maxResults: 5,                         // Max. number of rendered results | (Optional)
    highlight: true,                       // Highlight matching results      | (Optional)
    resultItem: {                          // Rendered result item            | (Optional)
      content: (data, source) => {
        source.setAttribute('class', 'item-result');
        source.innerHTML = data.value.full_name;
      },
      element: "li"
    },
    onSelection: feedback => {
      $(idAutocomplete).val(feedback.selection.value.name);
      $(lastName).val(feedback.selection.value.last_name);
      $(ci).val(feedback.selection.value.ci);
      $(phone).val(feedback.selection.value.phone);
      $(idPerson).val(feedback.selection.value.id);
    }
  });
});

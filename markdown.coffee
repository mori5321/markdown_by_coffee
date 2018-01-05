class MarkdownEditor


  constructor: (editorId, displayId) ->
    @editor = document.getElementById(editorId)
    @display = document.getElementById(displayId)
    @setOptions()

  setOptions: () ->
    renderer = new marked.Renderer()
    renderer.code = (code, language) ->
      return '<pre'+'><code class="hljs">' + hljs.highlightAuto(code).value + '</code></pre>'


    marked.setOptions({
      breaks: true,
      renderer: renderer,
    })

  subscriptEditorOnKeyUp: ->
    lazyFunc = _.debounce @parseAndRenderMarkdown.bind(this), 300
    @editor.addEventListener "keyup", lazyFunc

  parseAndRenderMarkdown: () ->
    formatted = marked(@editor.value)
    @display.innerHTML = formatted


editor = new MarkdownEditor("markdownEditor", "markdownDisplay")
editor.subscriptEditorOnKeyUp()
module.exports =
  config:
    pep8DirToExecutable:
      type: 'string'
      default: ''

  activate: ->
    console.log 'activate linter-python-pep8'

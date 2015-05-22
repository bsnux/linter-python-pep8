linterPath = atom.packages.getLoadedPackage("linter").path
console.log(linterPath)
Linter = require "#{linterPath}/lib/linter"

class Pep8Linter extends Linter
  @syntax: ['source.python', 'source.python.django']

  cmd: 'pep8'

  executablePath: null

  linterName: 'pep8'

  # A regex pattern used to extract information from the executable's output.
  regex:
    ':(?<line>\\d+):(?<col>\\d+): ((?<error>E\\d+)|(?<warning>W\\d+)) (?<message>.*?)\n'

  constructor: (editor)->
    super(editor)

    errorCodes = atom.config.get 'linter-python-pep8.ignoreErrorCodes'

    if errorCodes
      @cmd += " --ignore=#{errorCodes.toString()}"

    @configSubscription = atom.config.observe 'linter-python-pep8.pep8DirToExecutable', =>
      @executablePath = atom.config.get 'linter-python-pep8.pep8DirToExecutable'

  destroy: ->
    super
    @configSubscription.dispose()

module.exports = Pep8Linter

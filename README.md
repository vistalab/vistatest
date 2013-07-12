The vistatest repository contains code to validate functionality of the vistasfoft tools. The vistatest repository has two dependencies:

(1) vistasoft: https://github.com/vistalab/vistasoft
(2) vistadata: http://white.stanford.edu/newlm/index.php/Vistadata

Core functionality of vistatest is based on Matlab's x-unit test suite (http://www.mathworks.com/matlabcentral/fileexchange/22846-matlab-xunit-test-framework). This is not a dependency because the necessary code is included in vistatest.

There are two simple uses of vistatest. 

(a) Call any of the validation files singly. For example
> test_mrInit

If it runs without error than mrInit has been validated.

(b) Call the script mrvTest to run all BOLD validation scripts and output a validation report. Example calls:
> mrvTest; % or

> mrvTest('~/myreport.txt) % or

> edit(mrvTest('~/myreport.m'));

Repostiory contents:

Directories <br>
anatomy:   test functions for anatomical processing, currently mostly empty <br>
bold:      test functions for functional processing.  <br>
diffusion: test functions for diffusion processing, currently mostly empty <br>
matlab_xunit: external code from Mathworks <br>

Files <br>
.gitignore: Don't include '*.m~' files in repository <br>
README.md: you are here <br>
mrvGetEvironment.m: 	returns information about code and machine <br>
mrvTest.m: script to call all bold test functions and output a validation report <br>
mrvTestRootPath.m: 	path to this repository <br>
test_CleanUpSVN.m: sets vistadata SVN respository to current version <br>


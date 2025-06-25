#include "handling_variables_mat.cpp"

//outVarFile and outVarDir must be global variables, created at startup
//CODE written in C. not c++ 
enum typeOfVar{
  MATRIX,      //we define a matrix of intended final size of numbers [N]x[M]
  INT,         //used for indexing (-large to large)  4 byte:  4*uint8
  BOOL,        //logical operations (bit wise) 1 Byte: uint8 = char
  DOUBLE       //used for any other need of single number
}

//create a Variable and store it "somewhere"
int createVariable(string varName, typeOfVar Type, size_t varSize)
{
    switch Type 
      { //this might just be neccesary for matrixes, but if intending to make
        // the environment resilient and backup data elsewhere, might be needed all.
      case MATRIX
        baseSize = sizeof(double)*varSize;
      case INT
        baseSize = sizeof(long int);
      case BOOL
        baseSize = sizeof(uint8);
      case DOUBLE
        baseSize = sizeof(double);
      }
    void* ptrVariable;
    ptrVariable = malloc(baseSize);
    addVariableToWorkspace(outDirFile,outVarFile,VarName,ptrVariable,varType,varSize);
    // void* = malloc(size_t Size); //size_t is a HW dependant atomic size. (Unsigned int). ex: 32 or 64 bits
    
}


void cleanWorkSpace()
{  //release all the memory from all the variables creates still in workspace

  int reading=1;
  while(reading)
  {
    //return pointers saved into outDirFile and frees allocated memory
    void* varRead;
    varRead = returnVariablesPointersFromWorkspace(outDirFile,outVarFile); //returns the variable Ptr
    //without deleting the files since we want to keep record of runing the code
    // and variable files are named as: basename_time_date_varName or alike
    free(varRead);
  }
}

//returns pointer to variable in workspace(dir file) and frees memory
// without deleting the files.
int deleteVariable(string varName)
{
    void* varRead;
    varRead = returnVarDataPointerFromWorkspace(outDirFile,outVarFile,VarName); 
    free(varRead);
}



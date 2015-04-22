#include <Python.h>

int main(int argc, char *argv[]) {
  PyObject *expr[3];
  PyObject *list;
  int i, s, e, r;

  if(argc<5) {
    fprintf(stderr,"Usage: <list> <start> <end> <repeat>\n\n\
Print list[start:end] *repeat");
    exit(0);
  }

  Py_SetProgramName(argv[0]);
  Py_Initialize();

  s = atoi(argv[argc - 3]);
  e = atoi(argv[argc - 2]);
  r = atoi(argv[argc - 1]);
  list = PyList_New(0); // Non-owning ref
  expr[0] = list;
  for (int i = 1; i < argc - 3; i++) {
    PyObject* item = Py_BuildValue("s", argv[i]); 
    PyList_Append(list, item);
    Py_CLEAR(item);
  }
  expr[1] = PySequence_GetSlice(expr[0], s, e);
  expr[2] = PySequence_Repeat(expr[1], r);
  PyObject_Print(expr[2], stdout, Py_PRINT_RAW);
  for (i = 0; i < 3; i++) Py_CLEAR(expr[i]);
  return 0;
}

//__________________________________________________________________________________
//... ¿#include this file in algorithms.cpp ?
// classRunIzhikevichOnNW.hpp    DEFINE BASECLASS
//__________________________________________________________________________________
 class run_Izhikevich_On_NW
{
  private
    double a_default = {5    0.02  10   10}; //{RS IB CH FS}
    double b_default = {0.2  0.2   1    1};
    double c_default = {-65  -55   -50  -65};
    double d_default = { 8   4    2    2};
    struct settings.

    void set_abcd(int mode);
    void run_izhikevich();
    void write_to_outfile();
    void load_data_chunk();

public:
    void run_Izhikevich_On_NW(settings); //ask and release memory for outResults buffer, set setting, initialize
    void run_algorithm();
}
  

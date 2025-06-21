#include "classRunIzhikevichOnNW.hpp"

  //PRIVATE
   // double a_default = {5    0.02  10   10}; //{RS IB CH FS}
    //double b_default = {0.2  0.2   1    1};
    //double c_default = {-65  -55   -50  -65};
    //double d_default = { 8   4    2    2};
    // struct settings.

    void set_settings(struct settings);
    void set_abcd();
    void run_izhikevich();
    void write_to_outfile();
    void load_data_chunk();

  //PUBLIC

    /* void set_settings(struct settings)   */
    void classRunIzhikevichOnNW::set_settings(struct_settings settings)
    {
      myObj.settings = settings;
      myObj.set_abcd;
    }

    /* 
        CONSTRUCTOR run_Izhikevich_On_NW
        ask and release memory for outResults buffer, set setting, initialize
      */
    void classRunIzhikevichOnNW::classRunIzhikevichOnNW(settings) 
    {
        myObj.set_settings(settings);
    }
    void classRunIzhikevichOnNW::run_algorithm()
    {
      
    }
}

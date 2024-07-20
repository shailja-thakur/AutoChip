module top_module (
  input d,   // input port
  input ena, // enable port
  output logic q // output port
);

  always_comb begin
    if (ena) // check if enable is high
      q = d; // set output equal to input when enable is high
    else
      q = q; // retain the previous value of output when enable is low
  end

endmodule

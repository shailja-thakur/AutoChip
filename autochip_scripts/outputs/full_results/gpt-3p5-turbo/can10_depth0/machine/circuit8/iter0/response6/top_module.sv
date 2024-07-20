module top_module (
  input clock,  // clock input
  input a,  // signal input
  output reg p,  // register p output
  output reg q  // register q output
);

  always @(negedge clock)  // triggered on negative edge of clock signal
    q <= a;  // assign current value of signal a to register q

  always @(a)  // triggered on any change of input signal a
  begin
    if (clock)  // if clock signal is high
      p <= a;  // assign current value of signal a to register p
  end

endmodule

module top_module( 
  input clk, // clock signal
  input [7:0] d, // data input
  input reset, // reset signal
  output reg [7:0] q // output
);

  reg [7:0] q_temp; // temporary storage for output
  
  always @ (negedge clk or posedge reset) begin
    if (reset)
      q_temp <= 8'h34; // set output to 0x34 during reset
    else
      q_temp <= d; // update output with input data
  end

  always @ (posedge clk) begin
    q <= q_temp; // update output on negative edge of clock
  end

endmodule

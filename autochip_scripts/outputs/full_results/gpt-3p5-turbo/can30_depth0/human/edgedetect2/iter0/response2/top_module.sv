module top_module(
  input clk,
  input [7:0] in,
  output reg [7:0] anyedge
);

  reg [7:0] prev_in; // register to store previous value of in
  
  always @(posedge clk) begin
    prev_in <= in; // store current value of in in prev_in register
    anyedge <= 0; // assume no edge detected initially
    
    // check for any edge for each bit position
    for (integer i = 0; i < 8; i = i + 1) begin
      if (in[i] != prev_in[i]) // detect edge
        anyedge[i] <= 1'b1; // set output bit high for detected edge
    end
  end
  
endmodule

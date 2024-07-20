module top_module(
  input clk,
  input reset,
  input [31:0] in,
  output reg [31:0] out);
  
  reg [31:0] d_last; // signal to store the previous value of in
  
  always @(posedge clk) begin
    if (reset) begin
      out <= 32'd0; // output value is 0 initially when reset is asserted
    end else begin
      d_last <= in; // store the previous value of in
      out <= out | (~in & d_last); // modify the output value
    end
  end

endmodule

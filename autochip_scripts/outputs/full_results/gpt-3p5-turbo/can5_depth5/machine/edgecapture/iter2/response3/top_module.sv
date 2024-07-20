module top_module(
  input clk,
  input reset,
  input [31:0] in,
  output reg [31:0] out);
  
  reg [31:0] d_last;
  reg [31:0] temp_out;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      out <= 0;
    else begin
      temp_out <= out | (~in & d_last);
      out <= temp_out;
    end
    
    d_last <= in;
  end
  
endmodule

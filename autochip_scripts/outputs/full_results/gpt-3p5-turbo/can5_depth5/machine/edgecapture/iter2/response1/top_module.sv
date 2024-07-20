module top_module(
  input clk,
  input reset,
  input [31:0] in,
  output reg [31:0] out);

  reg [31:0] d_last;
  reg [31:0] out_temp;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      out_temp <= 0;
      out <= 0;
    end
    else begin
      out_temp <= out | (~in & d_last);
      out <= out_temp;
    end
    
    d_last <= in;
  end
  
endmodule

module top_module(
  input wire clk,
  input wire reset,
  input wire [31:0] in,
  output reg [31:0] out);

  reg [31:0] d_last;
  reg [31:0] out_temp;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      out_temp <= 0;
    else begin
      out_temp <= out_temp | (~in & d_last);
      d_last <= in;
    end
  end
  
  always @(posedge clk) begin
    if (reset)
      out <= 0;
    else
      out <= out_temp;
  end
  
endmodule

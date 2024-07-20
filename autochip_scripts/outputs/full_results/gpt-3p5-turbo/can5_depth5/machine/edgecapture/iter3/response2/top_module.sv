module top_module(
  input clk,
  input reset,
  input [31:0] in,
  output reg [31:0] out);
  
  reg [31:0] d_last;
  reg clk_prev;
  
  always @(posedge clk) begin
    clk_prev <= 1'b1; // Store previous clk value
    if (reset) begin
      out <= 32'b0; // Reset out signal
      d_last <= 32'b0; // Reset d_last signal
    end
    else begin
      out <= out | (~in & d_last);
      d_last <= in;
    end
  end
  
endmodule

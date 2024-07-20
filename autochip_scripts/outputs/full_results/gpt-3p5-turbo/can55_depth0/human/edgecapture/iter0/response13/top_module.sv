module top_module(
  input clk,
  input reset,
  input [31:0] in,
  output reg [31:0] out);

  reg [31:0] previous_in;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      previous_in <= 32'b0;
      out <= 32'b0;
    end else begin
      out <= in & ~previous_in;
      previous_in <= in;
    end
  end
endmodule

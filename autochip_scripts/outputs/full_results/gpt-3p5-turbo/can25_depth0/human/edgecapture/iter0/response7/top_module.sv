module top_module(
  input clk,
  input reset,
  input [31:0] in,
  output reg [31:0] out
);

  reg [31:0] in_prev;
  reg [31:0] out_reg;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      in_prev <= 32'h0;
      out_reg <= 32'h0;
    end else begin
      in_prev <= in;
      out_reg <= in_prev & ~in;
    end
  end

  assign out = out_reg;

endmodule

module top_module(
  input wire clk,
  input wire reset,
  input wire [31:0] in,
  output reg [31:0] out);
  
  reg [31:0] d_last;
  reg [31:0] out_reg;

  always @(posedge clk) begin
    if (reset) begin
      out_reg <= 0;
      d_last <= 0;
    end else begin
      d_last <= in;
      out_reg <= out_reg | (~in & d_last);
    end
  end

  always @(posedge clk or posedge reset) begin
    if (reset)
      out <= 0;
    else
      out <= out_reg;
  end

endmodule

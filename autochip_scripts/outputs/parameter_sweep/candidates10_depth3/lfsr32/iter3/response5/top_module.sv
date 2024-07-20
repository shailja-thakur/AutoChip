module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  reg [31:0] q_reg;

  always @(posedge clk) begin
    if (reset)
      q_reg <= 32'b1;
    else begin
      q_reg <= {q_reg[31]^q_reg[21]^q_reg[1]^q_reg[0], q_reg[31:1]};
    end
  end

  // Synchronous output update
  always @(posedge clk) begin
    if (reset)
      q <= 32'b1;
    else
      q <= q_reg;
  end

endmodule

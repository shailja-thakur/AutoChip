module top_module(
  input clk,
  input shift_ena,
  input count_ena,
  input data,
  output reg [3:0] q);

  reg [3:0] shift_reg;
  reg [3:0] next_shift_reg;

  always @(posedge clk) begin
    if (shift_ena) begin
      next_shift_reg[3] = data;
      next_shift_reg[2:0] = shift_reg[3:1];
    end
    else begin
      next_shift_reg = shift_reg;
    end

    if (count_ena) begin
      next_shift_reg = shift_reg - 1;
    end

    shift_reg <= next_shift_reg;
  end

  assign q = shift_reg;

endmodule

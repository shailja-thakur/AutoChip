module top_module(
  input clk,
  input shift_ena,
  input count_ena,
  input data,
  output reg [3:0] q);

  reg [3:0] shift_reg;

  always @(posedge clk) begin
    if (count_ena) begin
      if (shift_reg != 0) begin
        shift_reg <= shift_reg - 1;
      end
    end

    if (shift_ena) begin
      shift_reg <= {shift_reg[2:0], data};
    end
  end

  always @(posedge clk) begin
    if (count_ena && !(shift_ena && count_ena))
      q <= shift_reg;
  end

endmodule

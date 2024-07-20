module top_module(
  input clk,
  input reset,
  output [3:1] ena,
  output reg [15:0] q
);

  reg [3:0] q0_reg, q1_reg, q2_reg, q3_reg;
  wire [3:0] q0_next, q1_next, q2_next, q3_next;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q0_reg <= 4'b0000;
      q1_reg <= 4'b0000;
      q2_reg <= 4'b0000;
      q3_reg <= 4'b0000;
    end
    else begin
      q0_reg <= q0_next;
      q1_reg <= q1_next;
      q2_reg <= q2_next;
      q3_reg <= q3_next;
    end
  end

  always @(posedge clk) begin
    if (reset) begin
      q0_next <= 4'b0000;
      q1_next <= 4'b0000;
      q2_next <= 4'b0000;
      q3_next <= 4'b0000;
    end
    else begin
      q0_next <= q0_reg + 4'b0001;
      q1_next <= q1_reg + (ena[1] ? 4'b0001 : 4'b0000);
      q2_next <= q2_reg + (ena[2] ? 4'b0001 : 4'b0000);
      q3_next <= q3_reg + (ena[3] ? 4'b0001 : 4'b0000);
    end
  end

  assign q = {q3_reg, q2_reg, q1_reg, q0_reg};

endmodule

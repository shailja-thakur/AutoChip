module top_module (
  input clk,
  input load,
  input ena,
  input [1:0] amount,
  input [63:0] data,
  output reg [64:0] q
);

  reg [63:0] shift_reg;
  reg [63:0] old_q;

  always @(posedge clk or negedge reset) begin
    if (load) begin
      shift_reg <= data;
    end else if (ena) begin
      shift_reg <= shift_reg << amount;
      if (amount[0] == 1) begin
        shift_reg[63:64] <= q[63];
      end else if (amount[1] == 1) begin
        shift_reg[63:64] <= q[56];
        shift_reg[55:0] <= q[0:55];
      end
    end
  end

  assign q = shift_reg;

endmodule
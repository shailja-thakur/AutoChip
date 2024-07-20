module top_module(
  input clk,
  input load,
  input [1:0] ena,
  input [99:0] data,
  output reg [99:0] q
);

  reg [1:0] ena_reg;
  reg [99:0] next_q;
  
  always @(posedge clk) begin
    ena_reg <= ena;
    if (load) begin
      q <= data;
    end else begin
      case (ena_reg)
        2'b01: next_q = {q[98:0], q[99]};
        2'b10: next_q = {q[0], q[99:1]};
        default: next_q = q;
      endcase
      q <= next_q;
    end
  end

endmodule

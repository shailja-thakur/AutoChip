module top_module (
  input clk,
  input a,
  output reg [2:0] q
);

  reg [2:0] next_q;

  always @(posedge clk) begin
    case ({a, q})
      2'b01: if (q < 7) next_q <= q + 1;
      default: next_q <= q;
    endcase
  end

  always @(posedge clk) begin
    q <= next_q;
  end

endmodule

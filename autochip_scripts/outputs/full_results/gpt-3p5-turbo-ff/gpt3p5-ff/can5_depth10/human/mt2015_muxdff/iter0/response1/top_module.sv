module top_module(
  input clk,
  input L,
  input q_in,
  input r_in,
  output reg Q);

  reg [2:0] r;
  reg [2:0] q;

  full_module full_module_inst(
    .r(r),
    .L(L),
    .clk(clk),
    .q(q)
  );

  always @(posedge clk) begin
    r <= r_in;
    q <= q_in;
  end

  assign Q = q;

endmodule
module full_module (
  input [2:0] r,
  input L,
  input clk,
  output reg [2:0] q
);

  always @(posedge clk) begin
    if (L) begin
      q <= r;
    end else begin
      q <= {q[1] ^ q[2], q[0], q[2]};
    end
  end

endmodule

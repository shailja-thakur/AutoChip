module top_module(
  input clk,
  input L,
  input q_in,
  input r_in,
  output reg Q);

  reg [2:0] r;
  reg [2:0] q;

  submodule submod1(r_in, q_in, clk, r[0], q[0]);
  submodule submod2(r_in, q_in, clk, r[1], q[1]);
  submodule submod3(r_in, q_in, clk, r[2], q[2]);

  always @(posedge clk) begin
    if (L) begin
      q <= r;
    end
    else begin
      q <= {q[1] ^ q[2], q[0], q[2]};
    end
  end

  assign Q = q[2];

endmodule
module submodule(
  input r_in,
  input q_in,
  input clk,
  output reg r_out,
  output reg q_out);

  reg r;
  reg q;

  always @(posedge clk) begin
    r <= r_in;
    q <= q_in;
  end

  assign r_out = r;
  assign q_out = q;

endmodule

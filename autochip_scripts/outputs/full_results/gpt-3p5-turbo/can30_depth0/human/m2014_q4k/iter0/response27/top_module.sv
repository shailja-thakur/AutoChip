module top_module (
  input clk,
  input resetn,
  input in,
  output out
);

  reg [3:0] d;
  reg [3:0] q;

  always @(posedge clk or negedge resetn)
  begin
    if (!resetn)
      q <= 4'b0;
    else
      q <= d;
  end

  always @(*)
    d[0] <= in;
    d[1] <= q[0];
    d[2] <= q[1];
    d[3] <= q[2];

  assign out = q[3];

endmodule

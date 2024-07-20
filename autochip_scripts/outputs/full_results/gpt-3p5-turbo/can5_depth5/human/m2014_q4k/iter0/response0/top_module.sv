module top_module (
    input clk,
    input resetn,
    input in,
    output out
);

  wire q1, q2, q3, q4;

  d_ff d1(.clk(clk), .resetn(resetn), .d(in), .q(q1));
  d_ff d2(.clk(clk), .resetn(resetn), .d(q1), .q(q2));
  d_ff d3(.clk(clk), .resetn(resetn), .d(q2), .q(q3));
  d_ff d4(.clk(clk), .resetn(resetn), .d(q3), .q(q4));

  assign out = q4;

endmodule
module d_ff (
    input clk,
    input resetn,
    input d,
    output reg q
);

  always @(posedge clk or negedge resetn) begin
    if (!resetn)
      q <= 1'b0;
    else
      q <= d;
  end

endmodule

module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

  reg [3:0] d;
  wire [3:0] q;

  // D flip-flops
  always @(posedge clk or negedge resetn) begin
    if (!resetn)
      d <= 4'b0000;
    else
      d <= {d[2:0], in};
  end

  assign q = d;

  // Output
  assign out = q[0];

endmodule

module top_module (
	input [2:0] in,
	output [1:0] out
);

  assign out = 0;

  always @(*) begin
    out[0] = in[0] + in[1] + in[2];
    out[1] = in[0] & in[1] | in[0] & in[2] | in[1] & in[2];
  end

endmodule

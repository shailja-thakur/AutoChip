module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

wire [3:0] s;
wire [3:0] t;

and(s[0], c, d);
and(s[1], not(c), not(d));
and(s[2], not(c), d);
and(s[3], c, d);

assign mux_in[0] = (s[3] & not(s[2]) & s[0] & not(s[1])) | (not(s[3]) & not(s[2]) & not(s[0]) & s[1]);
assign mux_in[1] = (s[3] & s[2] & not(s[0]) & not(s[1])) | (not(s[3]) & not(s[2]) & s[0] & s[1]);
assign mux_in[2] = (s[3] & s[2] & not(s[0]) & s[1]) | (not(s[3]) & not(s[2]) & not(s[0]) & not(s[1]));
assign mux_in[3] = (s[3] & not(s[2]) & s[0] & not(s[1])) | (s[3] & s[2] & s[0] & s[1]) | (not(s[3]) & not(s[2]) & not(s[0]) & s[1]);

endmodule

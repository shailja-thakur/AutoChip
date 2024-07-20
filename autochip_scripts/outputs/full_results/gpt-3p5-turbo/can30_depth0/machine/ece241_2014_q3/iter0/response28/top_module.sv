module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

wire a, b;
wire logic_or;
wire logic_and;
wire logic_not;

assign logic_or = c | d;
assign logic_and = c & d;
assign logic_not = ~d;

assign mux_in[0] = logic_or;
assign mux_in[1] = 0;
assign mux_in[2] = logic_not;
assign mux_in[3] = logic_and;

endmodule

module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

    wire [3:0] and_terms;

    // AND gates
    assign and_terms[0] = ~c & d;
    assign and_terms[1] = c & ~d;
    assign and_terms[2] = c & d;
    assign and_terms[3] = c & ~d;

    // 2-to-1 multiplexers
    wire [1:0] ab;
    wire [1:0] cd;
    assign ab[0] = 0;
    assign ab[1] = 0;
    assign cd[0] = c;
    assign cd[1] = d;

    wire [3:0] mux_out;
    assign mux_out[0] = and_terms[0];
    assign mux_out[1] = and_terms[1];
    assign mux_out[2] = and_terms[2];
    assign mux_out[3] = and_terms[3];

    // 4-to-1 multiplexer
    assign mux_in = (ab[1] & ab[0]) ? mux_out[0] : 
                   (~ab[1] & ab[0]) ? mux_out[1] :
                   (ab[1] & ~ab[0]) ? mux_out[2] :
                   (~ab[1] & ~ab[0]) ? mux_out[3] : 0;

endmodule

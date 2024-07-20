module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

    // Generating mux inputs based on the Karnaugh map
    // ab = 00
    assign mux_in[0] = ~c & d | c & ~d;
    
    // ab = 01
    assign mux_in[1] = 0;
    
    // ab = 11
    assign mux_in[2] = d;
    
    // ab = 10
    assign mux_in[3] = ~c | d;

endmodule

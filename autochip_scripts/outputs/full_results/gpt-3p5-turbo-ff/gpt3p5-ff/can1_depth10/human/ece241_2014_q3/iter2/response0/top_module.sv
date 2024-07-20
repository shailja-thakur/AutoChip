module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

    wire a, b;
    
    // Implementing the logic for a and b inputs of the multiplexer
    assign a = ~c & ~d;
    assign b = c & ~d;
    
    // Implementing the logic for the mux_in outputs based on the K-map
    assign mux_in[0] = a & b;
    assign mux_in[1] = ~a & b;
    assign mux_in[2] = ~a & ~b;
    assign mux_in[3] = a & ~b;

endmodule

module top_module (
    input [2:0] in,
    output [1:0] out
);

    // Combinational logic for adding the three input bits
	assign out[1] = in[2] & (in[1] ^ 1'b1) | (in[0] & in[1]) | (in[2] & in[0]);
	assign out[0] = in[0] ^ in[1] ^ in[2];
    
endmodule

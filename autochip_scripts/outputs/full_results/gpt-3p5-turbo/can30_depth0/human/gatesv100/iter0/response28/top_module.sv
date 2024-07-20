module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Logic for out_both
    always @(in) begin
        out_both[0] = in[0] & in[99]; // Check the first bit with the last bit
        for (int i = 1; i < 99; i = i+1) begin
            out_both[i] = in[i] & in[i-1]; // Check each bit with its left neighbor
        end
    end
    
    // Logic for out_any
    always @(in) begin
        out_any[99] = in[98] | in[99]; // Check the last bit with the second-to-last bit
        for (int i = 98; i > 0; i = i-1) begin
            out_any[i] = in[i] | in[i+1]; // Check each bit with its right neighbor
        end
    end
    
    // Logic for out_different
    always @(in) begin
        out_different[0] = in[0] != in[99]; // Check the first bit with the last bit
        for (int i = 1; i < 100; i = i+1) begin
            out_different[i] = in[i] != in[i-1]; // Check each bit with its left neighbor
        end
    end
    
endmodule

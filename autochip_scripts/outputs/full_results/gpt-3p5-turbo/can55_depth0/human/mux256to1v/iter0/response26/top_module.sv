module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
    
    wire [3:0] in_sel [63:0];
    wire [3:0] mux_out;
    
    // Split the input into 256 4-bit vectors
    generate
        genvar i;
        for (i = 0; i < 64; i = i + 1) begin : split_input
            assign in_sel[i] = in[(i*16) +: 4];
        end
    endgenerate

    // Implement the multiplexer
    assign mux_out = sel < 64 ? in_sel[sel] : 4'b0;
    
    // Output the selected 4-bit vector
    assign out = mux_out;
    
endmodule

module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

reg [3:0] unpacked [0:255];

// Unpack the 1024-bit input into individual 4-bit inputs
generate
    genvar i;
    for (i = 0; i < 256; i = i + 1) begin : unpack_loop
        assign unpacked[i] = in[i*4 +: 4];
    end
endgenerate

// Define the multiplexer
always @(*) begin
    case (sel)
        0: out = unpacked[sel];
        1: out = unpacked[sel];
        2: out = unpacked[sel];
        // Add more cases for the remaining combinations
        default: out = 4'b0;
    endcase
end

endmodule

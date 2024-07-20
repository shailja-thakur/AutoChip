module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

reg [255:0] sel_bits;

// Splitting the 1024-bit input into 256 4-bit inputs
reg [3:0] in_bits [255:0];
generate
    genvar i;
    for (i = 0; i < 256; i = i + 1) begin : unpacking_block
        assign in_bits[i] = in[i*4 +: 4];
    end
endgenerate

// Assigning the selected 4-bit input to the output based on sel
always @(*) begin
    case (sel)
        8'b00000000: out = in_bits[0];
        8'b00000001: out = in_bits[1];
        8'b00000010: out = in_bits[2];
        8'b00000011: out = in_bits[3];
        // add more cases for all 256 inputs
        // ...
        default: out = 4'bxxxx;
    endcase
end

endmodule

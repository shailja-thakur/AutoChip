module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

// Create a 4-bit wide, 256-to-1 multiplexer. The 256 4-bit inputs are all packed into a single 1024-bit input vector. sel=0 should select bits in[3:0], sel=1 selects bits in[7:4], sel=2 selects bits in[11:8], etc.

reg [3:0] sel_2_0; // Intermediate register to hold sel[2:0]

always @* begin
	case (sel)
		0: sel_2_0 = 0; // sel[2:0] = 000
		1: sel_2_0 = 2; // sel[2:0] = 001
		2: sel_2_0 = 4; // sel[2:0] = 010
		3: sel_2_0 = 6; // sel[2:0] = 011
		4: sel_2_0 = 8; // sel[2:0] = 100
		5: sel_2_0 = 10; // sel[2:0] = 101
		6: sel_2_0 = 12; // sel[2:0] = 110
		7: sel_2_0 = 14; // sel[2:0] = 111
		default: sel_2_0 = 0; // Default value
	endcase
end

assign out = in[(sel_2_0 + 3):sel_2_0]; // Select the appropriate bits based on sel_2_0

endmodule

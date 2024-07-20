module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

reg [3:0] temp [255:0];

always @* begin
	for (int i=0; i<256; i=i+1) begin
		temp[i] = in[(i+1)*4-1 : i*4];
	end

	case (sel)
		0: out = temp[0];
		1: out = temp[1];
		2: out = temp[2];
		// add more cases for sel=3, sel=4, etc. if necessary
	endcase
end

endmodule

module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

reg [255:0] in_select [0:3];

always @*
begin
	case(sel)
		0: in_select <= in[3:0];
		1: in_select <= in[7:4];
		2: in_select <= in[11:8];
		3: in_select <= in[15:12];
		// Add more cases for sel values 4 to 255, as per the specified pattern
	endcase
end

always @*
begin
	case(sel)
		0: out <= in_select[sel];
		1: out <= in_select[sel - 1];
		2: out <= in_select[sel - 2];
		3: out <= in_select[sel - 3];
		// Add more cases for sel values 4 to 255, as per the specified pattern
	endcase
end

endmodule

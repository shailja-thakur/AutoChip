module top_module (
	input clk,
	input enable,
	input S,
	input A,
	input B,
	input C,
	output reg [7:0] q,
	output reg Z
);

reg [7:0] shift_register;
reg [2:0] addr;

always @(posedge clk) begin
	if (enable) begin
		shift_register <= shift_register << 1;
		shift_register[0] <= S;
	end
end

always @* begin
	case ({A,B,C})
		3'b000: addr = 0;
		3'b001: addr = 1;
		3'b010: addr = 2;
		3'b011: addr = 3;
		3'b100: addr = 4;
		3'b101: addr = 5;
		3'b110: addr = 6;
		3'b111: addr = 7;
		
		default: addr = 0;
	endcase
	
	Z = shift_register[addr];
end

assign q = shift_register;

endmodule

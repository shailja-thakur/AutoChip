module top_module (
	input clk,
	input enable,
	input S,
	input A,
	input B,
	input C,
	output reg Z
);

	reg [7:0] q;
	reg [2:0] address;

	always @(posedge clk) begin
		if (enable) begin
			q <= {q[6:0], S};
		end
	end

	always @* begin
		case ({A, B, C})
			3'b000: address = 3'b000;
			3'b001: address = 3'b001;
			3'b010: address = 3'b010;
			3'b011: address = 3'b011;
			3'b100: address = 3'b100;
			3'b101: address = 3'b101;
			3'b110: address = 3'b110;
			3'b111: address = 3'b111;
		endcase
	end

	always @* begin
		case (address)
			3'b000: Z = q[0];
			3'b001: Z = q[1];
			3'b010: Z = q[2];
			3'b011: Z = q[3];
			3'b100: Z = q[4];
			3'b101: Z = q[5];
			3'b110: Z = q[6];
			3'b111: Z = q[7];
		endcase
	end

endmodule

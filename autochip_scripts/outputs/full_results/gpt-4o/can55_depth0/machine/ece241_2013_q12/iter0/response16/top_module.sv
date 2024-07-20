module top_module (
	input clk,
	input enable,
	input S,
	input A,
	input B,
	input C,
	output reg Z
);

	reg [7:0] q; // 8-bit register
	wire [2:0] sel; // 3-bit multiplexer select signal

	assign sel = {A, B, C}; // Combine A, B, and C to form a 3-bit address

	always @(posedge clk) begin
		if (enable) begin
			q <= {q[6:0], S}; // Shift S into the register
		end
	end

	always @(*) begin
		case (sel)
			3'd0: Z = q[0];
			3'd1: Z = q[1];
			3'd2: Z = q[2];
			3'd3: Z = q[3];
			3'd4: Z = q[4];
			3'd5: Z = q[5];
			3'd6: Z = q[6];
			3'd7: Z = q[7];
			default: Z = 1'b0; // Default case if something goes wrong
		endcase
	end

endmodule

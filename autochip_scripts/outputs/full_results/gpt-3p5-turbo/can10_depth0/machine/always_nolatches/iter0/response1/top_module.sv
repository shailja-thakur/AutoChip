module top_module (
	input [15:0] scancode,
	output reg left,
	output reg down,
	output reg right,
	output reg up
);

	always @(*) begin
		left = (scancode == 16'hE06B) ? 1'b1 : 1'b0;
		down = (scancode == 16'hE072) ? 1'b1 : 1'b0;
		right = (scancode == 16'hE074) ? 1'b1 : 1'b0;
		up = (scancode == 16'hE075) ? 1'b1 : 1'b0;
	end

endmodule

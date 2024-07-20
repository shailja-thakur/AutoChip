module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg [2:0] Y,
	output reg z
);

	reg [2:0] next_state;
	reg [2:0] current_state;
	always @(posedge clk) begin
		current_state <= y;
		case ({x, current_state})
			3'b000: next_state <= 3'b000;
			3'b001: next_state <= 3'b100;
			3'b010: next_state <= 3'b001;
			3'b011: next_state <= 3'b001;
			3'b100: next_state <= 3'b011;
		endcase
	end

	always @(posedge clk) begin
		case (current_state)
			3'b000: begin
				Y <= 3'b000;
				z <= 1'b0;
			end
			3'b001: begin
				Y <= 3'b100;
				z <= 1'b0;
			end
			3'b010: begin
				Y <= 3'b001;
				z <= 1'b0;
			end
			3'b011: begin
				Y <= 3'b010;
				z <= 1'b1;
			end
			3'b100: begin
				Y <= 3'b100;
				z <= 1'b1;
			end
		endcase
	end
endmodule

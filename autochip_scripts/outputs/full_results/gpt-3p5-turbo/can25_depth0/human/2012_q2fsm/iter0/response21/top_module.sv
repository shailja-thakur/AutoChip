module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state_reg, state_next;

// State encoding:
// A - 3'b000
// B - 3'b001
// C - 3'b010
// D - 3'b011
// E - 3'b100
// F - 3'b101

always @(posedge clk or posedge reset) begin
	if (reset)
		state_reg <= 3'b000;
	else
		state_reg <= state_next;
end

always @(state_reg or w) begin
	case (state_reg)
		3'b000: begin
			if (w)
				state_next = 3'b001;
			else
				state_next = 3'b000;
		end
		3'b001: begin
			if (w)
				state_next = 3'b010;
			else
				state_next = 3'b011;
		end
		3'b010: begin
			if (w)
				state_next = 3'b100;
			else
				state_next = 3'b011;
		end
		3'b011: begin
			if (w)
				state_next = 3'b101;
			else
				state_next = 3'b000;
		end
		3'b100: begin
			if (w)
				state_next = 3'b100;
			else
				state_next = 3'b011;
		end
		3'b101: begin
			if (w)
				state_next = 3'b010;
			else
				state_next = 3'b011;
		end
		default:
			state_next = 3'b000;
	endcase
end

always @(*) begin
	case (state_reg)
		3'b000: z = 1'b0;
		3'b001: z = 1'b0;
		3'b010: z = 1'b1;
		3'b011: z = 1'b0;
		3'b100: z = 1'b0;
		3'b101: z = 1'b1;
		default: z = 1'b0;
	endcase
end

endmodule

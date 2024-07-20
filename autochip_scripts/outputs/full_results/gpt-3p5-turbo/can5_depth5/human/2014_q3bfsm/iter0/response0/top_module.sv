module top_module (
	input clk,
	input reset,
	input x,
	output reg z,
	output reg [2:0] y
);

	// State variables
	reg [2:0] y_next;
	reg [2:0] y_reg;

	// Next state logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			y_next <= 3'b000;
		else begin
			case (y_reg)
				3'b000: if (x) y_next <= 3'b001; else y_next <= 3'b000;
				3'b001: if (x) y_next <= 3'b100; else y_next <= 3'b001;
				3'b010: if (x) y_next <= 3'b001; else y_next <= 3'b010;
				3'b011: if (x) y_next <= 3'b010; else y_next <= 3'b001;
				3'b100: if (x) y_next <= 3'b100; else y_next <= 3'b011;
			endcase
		end
	end

	// Current state registers
	always @(posedge clk or posedge reset) begin
		if (reset)
			y_reg <= 3'b000;
		else
			y_reg <= y_next;
	end

	// Output logic
	always @(posedge clk) begin
		case (y_reg)
			3'b011: z <= 1'b1;
			default: z <= 1'b0;
		endcase
	end

endmodule

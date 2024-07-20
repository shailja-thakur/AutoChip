module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	reg [1:0] state;
	reg out;

	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b00; // reset to state A
		else begin
			case (state)
				2'b00: if (in) state <= 2'b01; else state <= 2'b00; // A
				2'b01: if (in) state <= 2'b01; else state <= 2'b10; // B
				2'b10: if (in) state <= 2'b11; else state <= 2'b00; // C
				2'b11: if (in) state <= 2'b01; else state <= 2'b10; // D
			endcase
		end
	end

	always @(state) begin
		case (state)
			2'b00: out = 1'b0; // A
			2'b01: out = 1'b0; // B
			2'b10: out = 1'b0; // C
			2'b11: out = 1'b1; // D
		endcase
	end

endmodule

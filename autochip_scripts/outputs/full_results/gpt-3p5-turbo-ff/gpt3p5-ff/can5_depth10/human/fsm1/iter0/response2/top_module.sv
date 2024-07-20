module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// State register
	reg [1:0] state;

	// Output register
	reg out;

	// Next state logic
	always @(posedge clk or negedge areset) begin
		if (areset) begin
			state <= 2'b10; // Reset to state B
		end else begin
			case (state)
				2'b00: begin // State A, input 0
					if (in == 1'b0) begin
						state <= 2'b10; // Next state is B
					end else begin
						state <= 2'b00; // Next state is A
					end
				end
				2'b01: begin // State A, input 1
					if (in == 1'b0) begin
						state <= 2'b10; // Next state is B
					end else begin
						state <= 2'b01; // Next state is A
					end
				end
				2'b10: begin // State B, input 0
					if (in == 1'b0) begin
						state <= 2'b01; // Next state is A
					end else begin
						state <= 2'b10; // Next state is B
					end
				end
				2'b11: begin // State B, input 1
					if (in == 1'b0) begin
						state <= 2'b01; // Next state is A
					end else begin
						state <= 2'b11; // Next state is B
					end
				end
			endcase
		end
	end

	// Output logic
	always @(state) begin
		case (state)
			2'b00: out = 1'b0;
			2'b01: out = 1'b1;
			2'b10: out = 1'b0;
			2'b11: out = 1'b1;
		endcase
	end

endmodule

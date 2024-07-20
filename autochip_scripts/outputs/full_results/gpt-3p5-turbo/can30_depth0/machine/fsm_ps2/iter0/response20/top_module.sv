module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);
	// Define states
	parameter BYTE1 = 2'b00;  // State BYTE1
	parameter BYTE2 = 2'b01;  // State BYTE2
	parameter BYTE3 = 2'b10;  // State BYTE3
	parameter DONE = 2'b11;   // State DONE

	// Internal signals
	reg [1:0] state_reg;
	reg [1:0] state_next;

	// State register
	always @(posedge clk or posedge reset) begin
		if (reset)
			state_reg <= BYTE1;
		else
			state_reg <= state_next;
	end

	// Next state logic
	always @(*) begin
		case (state_reg)
			BYTE1: begin
				if (in[2])
					state_next = BYTE2;
				else
					state_next = BYTE1;
			end
			BYTE2: begin
				state_next = BYTE3;
			end
			BYTE3: begin
				state_next = DONE;
			end
			DONE: begin
				if (in[2])
					state_next = BYTE2;
				else
					state_next = BYTE1;
			end
		endcase
	end

	// Output logic
	assign done = (state_reg == DONE);

endmodule

module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

	// Define states using an enumerated data type
	typedef enum logic [1:0] {
		BYTE1,
		BYTE2,
		BYTE3,
		DONE
	} state_t;

	// Define state register and next state variables
	reg state_t state, next_state;

	// Define 24-bit register for out_bytes output
	reg [23:0] out_bytes_reg;

	// Assign done signal based on current state
	assign done = (state == DONE);

	// Sequential logic
	always @(posedge clk) begin
		if (reset) begin
			// Initialize values on reset
			state <= BYTE1;
			next_state <= BYTE1;
			out_bytes_reg <= 0;
		end else begin
			// Update state based on next state
			state <= next_state;

			// Update out_bytes register if done signal is set
			if (state == DONE) begin
				out_bytes_reg <= out_bytes_reg;
			end else begin
				out_bytes_reg <= {out_bytes_reg[15:0], in};
			end
		end
	end

	// Combinational logic for next state
	always @(*) begin
		case (state)
			BYTE1: begin
				if (in[2] == 1) begin
					next_state = BYTE2;
				end else begin
					next_state = BYTE1;
				end
			end

			BYTE2: begin
				next_state = BYTE3;
			end

			BYTE3: begin
				if (in[2] == 1) begin
					next_state = DONE;
				end else begin
					next_state = BYTE1;
				end
			end

			DONE: begin
				next_state = BYTE1;
			end
		endcase
	end

	// Assign updated out_bytes value to output
	assign out_bytes = out_bytes_reg;

endmodule

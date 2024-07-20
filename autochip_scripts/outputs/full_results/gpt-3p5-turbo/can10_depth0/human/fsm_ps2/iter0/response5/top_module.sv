module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);
	
	// Enum type to define states
	typedef enum logic [1:0] {
		IDLE,
		BYTE1,
		BYTE2,
		BYTE3
	} state_type;
	
	// Registers
	reg state_type state, next_state;
	reg [7:0] byte1, byte2, byte3;
	reg done_reg;
	
	// Combinational logic
	always_comb begin
		case (state)
			IDLE: begin
				if (in[3] == 1) begin
					next_state = BYTE1;
					byte1 = in;
				end
				else begin
					next_state = IDLE;
				end
			end

			BYTE1: begin
				next_state = BYTE2;
				byte2 = in;
			end

			BYTE2: begin
				next_state = BYTE3;
				byte3 = in;
			end

			BYTE3: begin
				next_state = IDLE;
				byte1 = 8'b0;
				byte2 = 8'b0;
				byte3 = 8'b0;
				done_reg = 1'b1;
			end
		endcase
	end
	
	// Sequential logic
	always_ff @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
			byte1 <= 8'b0;
			byte2 <= 8'b0;
			byte3 <= 8'b0;
			done_reg <= 1'b0;
		end
		else begin
			state <= next_state;
			done <= done_reg;
		end
	end
endmodule

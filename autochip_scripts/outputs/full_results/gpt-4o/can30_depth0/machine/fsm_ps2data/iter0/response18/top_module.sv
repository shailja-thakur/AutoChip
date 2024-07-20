module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);
	
	// State encoding
	typedef enum logic [1:0] {
		BYTE1 = 2'b00,
		BYTE2 = 2'b01,
		BYTE3 = 2'b10,
		DONE  = 2'b11
	} state_t;
	
	// State variables
	state_t state, next_state;
	reg [23:0] shift_reg;
	
	// Sequential logic for state transition
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= BYTE1;
		end else begin
			state <= next_state;
		end
	end
	
	// Combinational logic for state transitions
	always @(*) begin
		next_state = state; // Default to hold the current state
		done = 1'b0;        // Default done to 0
		case (state)
			BYTE1: begin
				if (in[3] == 1'b1) begin
					next_state = BYTE2;
				end else begin
					next_state = BYTE1;
				end
			end
			BYTE2: begin
				next_state = BYTE3;
			end
			BYTE3: begin
				next_state = DONE;
			end
			DONE: begin
				done = 1'b1;
				if (in[3] == 1'b0) begin
					next_state = BYTE1;
				end else begin
					next_state = DONE;
				end
			end
		endcase
	end
	
	// Sequential logic for output and shift register update
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			shift_reg <= 24'b0;
			out_bytes <= 24'b0;
		end else begin
			case (state)
				BYTE1: begin
					if (in[3] == 1'b1)
						shift_reg <= {shift_reg[15:0], in};
				end
				BYTE2: begin
					shift_reg <= {shift_reg[15:0], in};
				end
				BYTE3: begin
					shift_reg <= {shift_reg[15:0], in};
				end
				DONE: begin
					out_bytes <= shift_reg;
					if (in[3] == 1'b0) begin
						shift_reg <= 24'b0;
						out_bytes <= 24'b0;
					end
				end
			endcase
		end
	end
	
endmodule

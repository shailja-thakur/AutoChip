module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	// Define state encoding
	typedef enum reg [1:0] {
		BYTE1 = 2'b00,
		BYTE2 = 2'b01,
		BYTE3 = 2'b10,
		DONE  = 2'b11
	} state_t;
	
	state_t state, next_state;

	reg [23:0] temp_reg;

	// Update state
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= BYTE1;
			temp_reg <= 24'd0;
			out_bytes <= 24'd0;
		end else begin
			state <= next_state;
			if (state != DONE) begin
				temp_reg <= (temp_reg << 8) | in;
			end
			if (done) begin
				out_bytes <= temp_reg;
			end
		end
	end

	// FSM next state logic
	always_comb begin
		done = 0;
		case (state)
			BYTE1: begin
				if (in[2]) begin
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
				done = 1;
				if (!in[2]) begin
					next_state = BYTE1;
				end else begin
					next_state = DONE;
				end
			end
			default: begin
				next_state = BYTE1;
			end
		endcase
	}

endmodule

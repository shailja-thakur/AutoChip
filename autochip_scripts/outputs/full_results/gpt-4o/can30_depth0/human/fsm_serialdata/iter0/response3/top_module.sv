module top_module (
	input clk,
	input in,
	input reset,
	output reg [7:0] out_byte,
	output reg done
);
	// State encoding
	typedef enum reg [3:0] {
		IDLE,
		START_BIT,
		BIT_0,
		BIT_1,
		BIT_2,
		BIT_3,
		BIT_4,
		BIT_5,
		BIT_6,
		BIT_7,
		STOP_BIT
	} state_t;
	
	state_t state, next_state;
	reg [7:0] shift_reg;
	reg [2:0] bit_count;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			bit_count <= 0;
			shift_reg <= 8'b0;
			out_byte <= 8'b0;
			done <= 0;
		end else begin
			state <= next_state;
			if (state == START_BIT) begin
				bit_count <= 0;
				shift_reg <= 8'b0;
			end else if (state >= BIT_0 && state <= BIT_7) begin
				shift_reg <= {in, shift_reg[7:1]};
				bit_count <= bit_count + 1;
			end else if (state == STOP_BIT) begin
				out_byte <= shift_reg;
				done <= 1;
			end else begin
				done <= 0;
			end
		end
	end
	
	always @(*) begin
		next_state = state;
		case (state)
			IDLE: begin
				if (in == 0) // Start bit detected
					next_state = START_BIT;
			end
			START_BIT: begin
				next_state = BIT_0;
			end
			BIT_0: begin
				next_state = BIT_1;
			end
			BIT_1: begin
				next_state = BIT_2;
			end
			BIT_2: begin
				next_state = BIT_3;
			end
			BIT_3: begin
				next_state = BIT_4;
			end
			BIT_4: begin
				next_state = BIT_5;
			end
			BIT_5: begin
				next_state = BIT_6;
			end
			BIT_6: begin
				next_state = BIT_7;
			end
			BIT_7: begin
				next_state = STOP_BIT;
			end
			STOP_BIT: begin
				if (in == 1) // Stop bit correct
					next_state = IDLE;
				else
					next_state = STOP_BIT; // Wait for the correct stop bit
			end
		endcase
	end
endmodule

module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

	// Define states
	typedef enum reg [2:0] {
		S_IDLE = 3'b000,
		S_ONE = 3'b001,
		S_TWO = 3'b010,
		S_THREE = 3'b011,
		S_FOUR = 3'b100,
		S_FIVE = 3'b101,
		S_SIX = 3'b110,
		S_SEVEN = 3'b111
	} state_t;
	
	state_t current_state, next_state;
	
	// State transition logic
	always @(posedge clk) begin
		if (reset) begin
			current_state <= S_IDLE;
		end else begin
			current_state <= next_state;
		end
	end
	
	// Next state logic
	always @(*) begin
		// Default values
		next_state = current_state;
		disc = 1'b0;
		flag = 1'b0;
		err = 1'b0;
		
		case (current_state)
			S_IDLE: begin
				if (in == 1'b1) begin
					next_state = S_ONE;
				end
			end
			
			S_ONE: begin
				if (in == 1'b1) begin
					next_state = S_TWO;
				end else begin
					next_state = S_IDLE;
				end
			end
			
			S_TWO: begin
				if (in == 1'b1) begin
					next_state = S_THREE;
				end else begin
					next_state = S_IDLE;
				end
			end
			
			S_THREE: begin
				if (in == 1'b1) begin
					next_state = S_FOUR;
				end else begin
					next_state = S_IDLE;
				end
			end
			
			S_FOUR: begin
				if (in == 1'b1) begin
					next_state = S_FIVE;
				end else begin
					next_state = S_IDLE;
				end
			end
			
			S_FIVE: begin
				if (in == 1'b1) begin
					next_state = S_SIX;
				end else begin
					next_state = S_IDLE;
				end
			end
			
			S_SIX: begin
				if (in == 1'b1) begin
					next_state = S_SEVEN;
					flag = 1'b1;  // 01111110 sequence detected.
				end else begin
					next_state = S_IDLE;
					disc = 1'b1;  // 0111110 sequence detected.
				end
			end
			
			S_SEVEN: begin
				if (in == 1'b1) begin
					err = 1'b1; // 01111111 sequence detected.
				end
				next_state = S_IDLE;  // Always reset after error flag.
			end
		endcase
	end

endmodule

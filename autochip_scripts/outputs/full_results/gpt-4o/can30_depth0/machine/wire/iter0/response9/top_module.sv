module top_module(
	input clk, 
	input reset,
	output reg [7:0] data_out, 
	output reg valid_out);

	// Define states
	typedef enum reg [1:0] {
		IDLE = 2'b00,
		WAIT = 2'b01,
		PROCESS = 2'b10,
		DONE = 2'b11
	} state_t;
	
	state_t state, next_state;

	// Internal signals
	reg [7:0] counter;
	
	// State transitions
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			counter <= 8'b0;
			data_out <= 8'b0;
			valid_out <= 1'b0;
		end else begin
			state <= next_state;
			if (state == WAIT) counter <= counter + 1;
			if (state == IDLE) counter <= 0;
		end
	end
	
	// Next state logic and output logic
	always @(*) begin
		case (state)
			IDLE: begin
				if (!reset) begin
					next_state = WAIT;
					data_out = 8'b0;
					valid_out = 1'b0;
				end else begin
					next_state = IDLE;
				end
			end
			
			WAIT: begin
				if (counter < 8'd100) begin
					next_state = WAIT;
					data_out = 8'b0;
				end else begin
					next_state = PROCESS;
				end
			end
			
			PROCESS: begin
				next_state = DONE;
				data_out = 8'd255; // Example data processing
			end

			DONE: begin
				next_state = IDLE;
				valid_out = 1'b1;
			end
			
			default: begin
				next_state = IDLE;
			end
		endcase
	end
endmodule

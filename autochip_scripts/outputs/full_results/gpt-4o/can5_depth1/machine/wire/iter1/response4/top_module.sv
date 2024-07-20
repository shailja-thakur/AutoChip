module top_module(
	input wire clk,
	input wire reset,
	output wire out
);

	reg [7:0] data_out;
	reg valid_out;

	// FSM states
	typedef enum reg [1:0] {
		IDLE = 2'b00,
		WAIT = 2'b01,
		PROCESS = 2'b10,
		DONE = 2'b11
	} state_t;

	state_t state, next_state;
	reg [7:0] counter;

	// State transitions
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			counter <= 8'd0;
		end else begin
			state <= next_state;
			if (state == WAIT) begin
				counter <= counter + 1;
			end else begin
				counter <= 8'd0;
			end
		end
	end

	// Next state logic
	always @(*) begin
		case (state)
			IDLE: begin
				next_state = WAIT;
				data_out = 8'b0;
				valid_out = 1'b0;
			end
			
			WAIT: begin
				if (counter == 8'd15) begin
					next_state = PROCESS;
				end else begin
					next_state = WAIT;
				end
				data_out = 8'b0;
				valid_out = 1'b0;
			end

			PROCESS: begin
				next_state = DONE;
				data_out = counter;  // Example processed data
				valid_out = 1'b0;
			end

			DONE: begin
				next_state = IDLE;
				data_out = data_out;
				valid_out = 1'b1;
			end
			
			default: begin
				next_state = IDLE;
				data_out = 8'b0;
				valid_out = 1'b0;
			end
		endcase
	end

	assign out = valid_out;

endmodule

module top_module(
	input wire clk,
	input wire reset,
	output reg [7:0] data_out,
	output reg valid_out
);

	// State encoding
	typedef enum reg [1:0] {
		IDLE = 2'b00,
		WAIT = 2'b01,
		PROCESS = 2'b10,
		DONE = 2'b11
	} state_t;

	state_t state, next_state;
	reg [3:0] counter;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			counter <= 0;
			data_out <= 8'b0;
			valid_out <= 1'b0;
		end else begin
			state <= next_state;
			if (state == WAIT) counter <= counter + 1;
			if (state == IDLE) counter <= 0;
		end
	end

	always @* begin
		next_state = state;
		case (state)
			IDLE: begin
				data_out = 8'b0;
				valid_out = 1'b0;
				if (reset) next_state = WAIT;
			end
			WAIT: begin
				data_out = 8'b0;
				valid_out = 1'b0;
				if (counter == 4'd10) next_state = PROCESS;
			end
			PROCESS: begin
				data_out = 8'hFF; // example processed data
				valid_out = 1'b0;
				next_state = DONE;
			end
			DONE: begin
				valid_out = 1'b1;
				next_state = IDLE;
			end
			default: begin
				next_state = IDLE;
			end
		endcase
	end

endmodule

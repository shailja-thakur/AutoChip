module stimulus_gen(
	output reg clk,
	output reg rst,
	output reg [7:0] data,
	output reg valid
);

	// Clock generation
	always begin
		clk = 0;
		#5 clk = 1;
		#5;
	end

	// Reset generation
	initial begin
		rst = 1;
		#15 rst = 0;
	end

endmodule
module top_module(
	input clk,
	input rst,
	output reg [7:0] data_out,
	output reg valid_out
);

	// State encoding
	typedef enum reg [1:0] {IDLE, WAIT, PROCESS, DONE} state_t;
	state_t state, next_state;

	// Internal signals
	reg [7:0] counter;

	// State transition and output logic
	always @(posedge clk or posedge rst) begin
		if (rst) begin
			state <= IDLE;
			counter <= 0;
			data_out <= 0;
			valid_out <= 0;
		end else begin
			state <= next_state;
			if (state == WAIT) counter <= counter + 1;
		end
	end

	// Next state logic
	always @(*) begin
		case (state)
			IDLE: begin
				data_out = 0;
				valid_out = 0;
				if (!rst) next_state = WAIT;
				else next_state = IDLE;
			end
			WAIT: begin
				data_out = 0;
				valid_out = 0;
				if (counter >= 8'd10) next_state = PROCESS;
				else next_state = WAIT;
			end
			PROCESS: begin
				data_out = counter;
				valid_out = 0;
				next_state = DONE;
			end
			DONE: begin
				valid_out = 1;
				next_state = IDLE;
			end
			default: next_state = IDLE;
		endcase
	end

endmodule

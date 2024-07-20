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
	reg [7:0] counter;

	// Next state logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
		end else begin
			state <= next_state;
		end
	end

	// State transition logic
	always @(*) begin
		case (state)
			IDLE: begin
				if (reset) begin
					next_state = IDLE;
				end else begin
					next_state = WAIT;
				end
			end
			WAIT: begin
				if (counter >= 8'd100) begin // Assume threshold is 100 for demonstration purposes
					next_state = PROCESS;
				end else begin
					next_state = WAIT;
				end
			end
			PROCESS: begin
				next_state = DONE;
			end
			DONE: begin
				next_state = IDLE;
			end
			default: next_state = IDLE;
		endcase
	end

	// Output logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			data_out <= 8'd0;
			valid_out <= 1'b0;
			counter <= 8'd0;
		end else begin
			case (state)
				IDLE: begin
					data_out <= 8'd0;
					valid_out <= 1'b0;
					counter <= 8'd0;
				end
				WAIT: begin
					data_out <= 8'd0;
					valid_out <= 1'b0;
					counter <= counter + 8'd1;
				end
				PROCESS: begin
					data_out <= 8'hFF; // Assume some data is being processed
				end
				DONE: begin
					valid_out <= 1'b1;
				end
			endcase
		end
	end

endmodule

module top_module (
	input wire clk,
	input wire reset,
	output reg [7:0] data_out,   // assuming 8-bit data output
	output reg valid_out
);

	// State encoding
	typedef enum reg [1:0] {
		IDLE = 2'b00,
		WAIT = 2'b01,
		PROCESS = 2'b10,
		DONE = 2'b11
	} state_t;

	// Internal signals
	reg [1:0] state, next_state;
	reg [3:0] counter;  // Assuming 4-bit counter for demonstration

	// Combinational logic for state transition
	always @(*) begin
		case (state)
			IDLE: begin
				if (reset)
					next_state = IDLE;
				else
					next_state = WAIT;
			end
			WAIT: begin
				if (counter == 4'd15)  // Assuming threshold is 15
					next_state = PROCESS;
				else
					next_state = WAIT;
			end
			PROCESS: begin
				next_state = DONE;
			end
			DONE: begin
				next_state = IDLE;
			end
			default: begin
				next_state = IDLE;
			end
		endcase
	end

	// Sequential logic for state update and output logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			counter <= 4'd0;
			data_out <= 8'd0;
			valid_out <= 1'b0;
		end else begin
			state <= next_state;
			case (next_state)
				IDLE: begin
					counter <= 4'd0;
					data_out <= 8'd0;
					valid_out <= 1'b0;
				end
				WAIT: begin
					counter <= counter + 1;
					data_out <= 8'd0;
				end
				PROCESS: begin
					data_out <= 8'hAC;  // Assuming some data value
				end
				DONE: begin
					valid_out <= 1'b1;
				end
			endcase
		end
	end

endmodule

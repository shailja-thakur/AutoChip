module top_module(
	input clock,
	input reset,
	output reg data_out,
	output reg valid_out);

	reg [1:0] state;
	reg [7:0] counter;

	// Finite State Machine states
	localparam IDLE = 2'b00;
	localparam WAIT = 2'b01;
	localparam PROCESS = 2'b10;
	localparam DONE = 2'b11;

	// Initialize internal signals
	always @(posedge clock or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			counter <= 8'b0;
			data_out <= 1'b0;
			valid_out <= 1'b0;
		end else begin
			case (state)
				IDLE: begin
					counter <= 8'b0;
					data_out <= 1'b0;
					valid_out <= 1'b0;
					if (in) begin
						state <= WAIT;
					end
				end
				WAIT: begin
					counter <= counter + 1;
					data_out <= 1'b0;
					valid_out <= 1'b0;
					if (counter >= 8'b100) begin
						state <= PROCESS;
					end
				end
				PROCESS: begin
					data_out <= in;
					state <= DONE;
				end
				DONE: begin
					valid_out <= 1'b1;
					state <= IDLE;
				end
			endcase
		end
	end
endmodule

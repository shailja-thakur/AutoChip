module top_module(
	input wire clk,
	input wire rst,
	output reg out);

	reg [1:0] state;
	reg [7:0] counter;
	reg [7:0] data;
	reg valid;

	// FSM states
	parameter IDLE_STATE = 0;
	parameter WAIT_STATE = 1;
	parameter PROCESS_STATE = 2;
	parameter DONE_STATE = 3;

	// Assign initial values to signals
	always @(posedge clk or posedge rst) begin
		if (rst) begin
			state <= IDLE_STATE;
			counter <= 0;
			data <= 0;
			valid <= 0;
		end else begin
			case(state)
				IDLE_STATE: begin
					counter <= 0;
					data <= 0;
					valid <= 0;
					if (in) begin
						state <= WAIT_STATE;
					end
				end
				WAIT_STATE: begin
					counter <= counter + 1;
					data <= 0;
					valid <= 0;
					if (counter == 10) begin // Change 10 to your desired threshold value
						state <= PROCESS_STATE;
					end
				end
				PROCESS_STATE: begin
					data <= in;
					valid <= 0;
					state <= DONE_STATE;
				end
				DONE_STATE: begin
					valid <= 1;
					state <= IDLE_STATE;
				end
			endcase
		end
	end
	
	// Assign output
	assign out = data;

endmodule

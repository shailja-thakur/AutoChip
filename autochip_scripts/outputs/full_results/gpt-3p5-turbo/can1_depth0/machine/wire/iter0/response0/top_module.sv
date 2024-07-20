module top_module(
	input wire clk,
	input wire reset,
	output reg data_out,
	output reg valid);

	reg [1:0] state;
	reg [3:0] counter;

	// FSM states
	parameter IDLE = 2'b00;
	parameter WAIT = 2'b01;
	parameter PROCESS = 2'b10;
	parameter DONE = 2'b11;

	// Reset state and initializations
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= IDLE;
		else
			state <= state;
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			counter <= 0;
			data_out <= 0;
			valid <= 0;
		end else begin
			case(state)
				IDLE: begin
					counter <= 0;
					data_out <= 0;
					valid <= 0;
					if (in) // Example condition to transition to WAIT state. Please modify this condition as per your requirement.
						state <= WAIT;
				end
				
				WAIT: begin
					counter <= counter + 1;
					data_out <= 0;
					valid <= 0;
					if (counter >= 3) // Example threshold condition to transition to PROCESS state. Please modify this condition as per your requirement.
						state <= PROCESS;
				end
				
				PROCESS: begin
					data_out <= in; // Replace 'in' with the actual data being processed
					state <= DONE;
				end
				
				DONE: begin
					valid <= 1;
					state <= IDLE;
				end
			endcase
		end
	end
	
endmodule

module top_module(
	input wire clk,
	input wire reset,
	output reg out,
	output reg valid);

	// Internal signals
	reg [1:0] state;
	reg [7:0] counter;
	reg [7:0] data_output;
	
	// FSM states
	parameter IDLE = 2'b00;
	parameter WAIT = 2'b01;
	parameter PROCESS = 2'b10;
	parameter DONE = 2'b11;
	
	// Initial state and assignments
	initial begin
		state <= IDLE;
		counter <= 8'd0;
		data_output <= 8'd0;
	end
	
	// FSM logic
	always @(posedge clk) begin
		case(state)
			IDLE: begin
				if(reset) begin
					counter <= 8'd0;
					data_output <= 8'd0;
				end
				state <= WAIT;
			end
			WAIT: begin
				counter <= counter + 1;
				data_output <= 8'd0;
				if(counter >= 8'hFF) begin
					state <= PROCESS;
				end
			end
			PROCESS: begin
				data_output <= in;
				state <= DONE;
			end
			DONE: begin
				valid <= 1;
				state <= IDLE;
			end
		endcase
	end
endmodule

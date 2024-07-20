module top_module(
    input clk,
    input reset,
    output reg data_output,
    output reg valid_output
    ); 
	
	// Internal signals
	reg [1:0] state;
	reg [7:0] counter;
	
	// FSM states
	parameter IDLE = 2'b00;
	parameter WAIT = 2'b01;
	parameter PROCESS = 2'b10;
	parameter DONE = 2'b11;
	
	// Initializing signals
	always @(posedge reset) begin
		state <= IDLE;
		counter <= 8'b0;
		data_output <= 1'b0;
		valid_output <= 1'b0;
	end
	
	// FSM Transitions
	always @(posedge clk) begin
		case(state)
			IDLE: begin
				if(reset)
					state <= IDLE;
				else
					state <= WAIT;
			end
			
			WAIT: begin
				counter <= counter + 1;
				if(counter == 8'b11111111)
					state <= PROCESS;
				else
					state <= WAIT;
			end
			
			PROCESS: begin
				state <= DONE;
			end
			
			DONE: begin
				valid_output <= 1'b1;
				state <= IDLE;
			end
			
			default: state <= IDLE; // Default state
		endcase
	end
	
	// Output assignments
	always @(posedge clk) begin
		case(state)
			IDLE, WAIT: begin
				data_output <= 1'b0;
				valid_output <= 1'b0;
			end
			
			PROCESS: begin
				data_output <= in;
			end
			
			default: begin
				data_output <= 1'b0;
				valid_output <= 1'b0;
			end
		endcase
	end
endmodule

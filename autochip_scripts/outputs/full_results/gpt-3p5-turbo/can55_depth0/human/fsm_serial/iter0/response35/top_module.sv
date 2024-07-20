module top_module (
    input clk,
    input in,
    input reset,
    output done
);

	// Define the states
	parameter START = 2'b00;
	parameter RECEIVE = 2'b01;
	parameter STOP = 2'b10;
	
	reg [1:0] state, next_state;
	reg done;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= START;
		else
			state <= next_state;
	end
	
	always @* begin
		next_state = state;
		done = 0;
		
		case (state)
			START: begin
				if (in == 1'b0)
					next_state = RECEIVE;
			end
			
			RECEIVE: begin
				if (in == 1'b1)
					next_state = STOP;
			end
			
			STOP: begin
				if (in == 1'b1) begin
					next_state = START;
					done = 1;
				end
			end
		endcase
	end
	
endmodule

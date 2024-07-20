module top_module (
	input clk,
	input in,
	input reset,
	output done
);
	
	// Declare the states of the FSM
	typedef enum logic [2:0] {
		IDLE, START, DATA, STOP
	} state_t;
	
	// Declare the signals 
	reg [2:0] state;
	reg [7:0] data;
	reg done;
	reg start_detected;
	reg stop_detected;
	reg valid_byte;
	
	always_ff @(posedge clk, posedge reset)
	begin
		if (reset)
		begin
			state <= IDLE;
			data <= 8'b0;
			done <= 0;
			start_detected <= 0;
			stop_detected <= 0;
			valid_byte <= 0;
		end
		else
		begin
			case (state)
				IDLE:
					begin
						start_detected <= (in == 1'b0);
						if (start_detected)
						begin
							data <= 8'b0;
							state <= START;
						end
					end
					
				START:
					begin
						if (in == 1'b0)
						begin
							data <= {data[6:0], in};
							state <= DATA;
						end
					end
					
				DATA:
					begin
						if (in == 1'b0)
						begin
							data <= {data[6:0], in};
						end
						else
						begin
							state <= STOP;
						end
					end
					
				STOP:
					begin
						stop_detected <= (in == 1'b1);
						if (stop_detected)
						begin
							valid_byte <= 1;
							state <= IDLE;
						end
					end
					
				default: state <= IDLE;
			endcase
			
			done <= valid_byte;
		end
	end
	
endmodule

module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);
	
	// State definitions
	typedef enum logic [2:0] {
		IDLE,
		START_BIT,
		DATA_BITS,
		STOP_BIT
	} state_t;
	
	// Internal state and output variables
	state_t state;
	logic [7:0] data;
	logic start;
	
	// Synchronous reset
	always_ff @(posedge clk, posedge reset)
	begin
		if (reset)
			state <= IDLE;
		else
			state <= next_state;
	end
	
	// Next state and output logic
	always_comb
	begin
		case (state)
			IDLE:
				begin
					if (in == 0)
					begin
						start <= 1;
						data <= 0;
						state <= START_BIT;
					end
					else
					begin
						start <= 0;
						data <= 0;
						state <= IDLE;
					end
				end
			START_BIT:
				begin
					if (start)
					begin
						data[0] <= in;
						state <= DATA_BITS;
					end
					else
					begin
						data <= 0;
						state <= IDLE;
					end
				end
			DATA_BITS:
				begin
					if (start)
					begin
						if (data[7] == in)
							state <= STOP_BIT;
						else
							begin
								data <= 0;
								state <= IDLE;
							end
					end
					else
					begin
						data <= {data[6:0], in};
						state <= DATA_BITS;
					end
				end
			STOP_BIT:
				begin
					if (start)
					begin
						out_byte <= data;
						done <= 1;
						state <= IDLE;
					end
					else
					begin
						data <= 0;
						state <= IDLE;
					end
				end
		endcase
	end
	
endmodule

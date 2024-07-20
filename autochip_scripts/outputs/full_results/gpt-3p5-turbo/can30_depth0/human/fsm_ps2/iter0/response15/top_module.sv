module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);
	// Define the states
	typedef enum logic [1:0] {
		IDLE,
		BYTE_1,
		BYTE_2,
		BYTE_3
	} state_t;
	
	// Define the signals
	reg state_t state;
	reg [2:0] count;
	reg done;
	
	// State machine
	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
			count <= 0;
			done <= 0;
		end else begin
			case (state)
				IDLE:
					if (in[3]) begin
						state <= BYTE_1;
						count <= 1;
					end
				BYTE_1:
					state <= BYTE_2;
					count <= count + 1;
				BYTE_2:
					state <= BYTE_3;
					count <= count + 1;
				BYTE_3:
					state <= IDLE;
					count <= 0;
					done <= 1;
			endcase
		end
	end
endmodule

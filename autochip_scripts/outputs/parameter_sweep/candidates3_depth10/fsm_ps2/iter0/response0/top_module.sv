module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

	// Define the states
	typedef enum logic [1:0] {
		IDLE,
		BYTE1,
		BYTE2,
		BYTE3
	} state_t;
	
	// Define the signals
	reg state_t state;
	reg [7:0] byte1, byte2, byte3;

	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
			byte1 <= 8'b0;
			byte2 <= 8'b0;
			byte3 <= 8'b0;
			done <= 1'b0;
		end else begin
			case (state)
				IDLE: begin
					if (in[3] == 1'b1) begin
						state <= BYTE1;
						byte1 <= in;
					end
				end
				
				BYTE1: begin
					state <= BYTE2;
					byte2 <= in;
				end
				
				BYTE2: begin
					state <= BYTE3;
					byte3 <= in;
				end
				
				BYTE3: begin
					done <= 1'b1;
					state <= IDLE;
				end
			endcase
		end
    end
endmodule

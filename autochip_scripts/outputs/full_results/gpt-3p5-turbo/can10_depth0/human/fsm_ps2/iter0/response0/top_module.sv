module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);
	// Define the states
	typedef enum logic [1:0] {
		SEARCH,
		BYTE_1,
		BYTE_2,
		BYTE_3
	} state_t;
	
	reg state_t current_state;
	reg [7:0] byte_1;
	reg [7:0] byte_2;
	reg [7:0] byte_3;
	reg done;
	
	// Synchronous reset
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= SEARCH;
			byte_1 <= 8'b0;
			byte_2 <= 8'b0;
			byte_3 <= 8'b0;
			done <= 1'b0;
		end else begin
			case (current_state)
				SEARCH: begin
					if (in[3]) begin
						byte_1 <= in;
						current_state <= BYTE_1;
					end
				end
				
				BYTE_1: begin
					byte_1 <= in;
					current_state <= BYTE_2;
				end
				
				BYTE_2: begin
					byte_2 <= in;
					current_state <= BYTE_3;
				end
				
				BYTE_3: begin
					byte_3 <= in;
					current_state <= SEARCH;
					done <= 1'b1;
				end
			endcase
		end
	end
	
endmodule

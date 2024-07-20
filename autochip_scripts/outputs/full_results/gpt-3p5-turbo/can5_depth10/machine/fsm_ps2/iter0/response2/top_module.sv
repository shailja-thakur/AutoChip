module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);
	// Define states
	localparam [1:0] BYTE1 = 2'b00;
	localparam [1:0] BYTE2 = 2'b01;
	localparam [1:0] BYTE3 = 2'b10;
	localparam [1:0] DONE = 2'b11;
	
	reg [1:0] state; // State register
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= BYTE1; // Initialize state to BYTE1
		end else begin
			case (state)
				BYTE1: begin
					if (in[2]) begin
						state <= BYTE2; // Transition to BYTE2
					end
				end
				
				BYTE2: begin
					state <= BYTE3; // Transition to BYTE3
				end
				
				BYTE3: begin
					state <= DONE; // Transition to DONE
				end
				
				DONE: begin
					if (!in[2]) begin
						state <= BYTE1; // Transition to BYTE1
					end else begin
						state <= BYTE2; // Transition to BYTE2
					end
				end
			endcase
		end
	end
	
	assign done = (state == DONE); // Assert done signal when state machine is in the DONE state
endmodule

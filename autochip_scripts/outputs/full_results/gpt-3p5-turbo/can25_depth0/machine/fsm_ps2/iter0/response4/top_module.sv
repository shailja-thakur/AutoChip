module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

// Define the states as constants
localparam BYTE1 = 2'b00;
localparam BYTE2 = 2'b01;
localparam BYTE3 = 2'b10;
localparam DONE = 2'b11;

reg [1:0] state;  // State register

// Initialize state register on reset
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= BYTE1;
	end else begin
		case (state)
			BYTE1: begin
				// Check third bit of input
				if (in[2] == 1) begin
					state <= BYTE2;
				end
			end
			
			BYTE2: begin
				state <= BYTE3;
			end
			
			BYTE3: begin
				state <= DONE;
			end
			
			DONE: begin
				// Check third bit of input
				if (in[2] == 0) begin
					state <= BYTE1;
				end else begin
					state <= BYTE2;
				end
			end
		endcase
	end
end

// Output done signal when in the DONE state
assign done = (state == DONE);

endmodule

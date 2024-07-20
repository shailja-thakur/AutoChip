module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

	// Define states
	parameter BYTE1 = 2'b00;
	parameter BYTE2 = 2'b01;
	parameter BYTE3 = 2'b10;
	parameter DONE = 2'b11;
	
	// Declare register for state
	reg [1:0] state;
	
	// Output wire for done signal
	wire done_out;
	
	// State machine process
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= BYTE1;
		end else begin
			case (state)
				BYTE1: begin
					if (in[2] == 1'b1) begin
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
					if (in[2] == 1'b0) begin
						state <= BYTE1;
					end else begin
						state <= BYTE2;
					end
				end
				default: begin
					state <= BYTE1;
				end
			endcase
		end
	end
	
	// Output logic for done signal
	assign done_out = (state == DONE);
	assign done = done_out;
	
endmodule

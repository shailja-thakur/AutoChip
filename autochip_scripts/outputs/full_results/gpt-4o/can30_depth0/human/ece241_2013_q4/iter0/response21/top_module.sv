module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

	// States representing previous sensor levels
	reg [1:0] prev_state;
	
	// State encoding
	localparam LOW       = 2'b00;
	localparam BETWEEN_1_2 = 2'b01;
	localparam BETWEEN_2_3 = 2'b10;
	localparam HIGH      = 2'b11;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			// Reset all outputs and state
			fr3 <= 1'b1;
			fr2 <= 1'b1;
			fr1 <= 1'b1;
			dfr <= 1'b1;
			prev_state <= LOW;
		end else begin
			case (s)
				3'b111: begin
					// Above s[3]
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b0;
					dfr <= 1'b0;
					prev_state <= HIGH;
				end
				
				3'b011: begin
					// Between s[3] and s[2]
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b1;
					dfr <= (prev_state == LOW) ? 1'b1 : 1'b0;
					prev_state <= BETWEEN_2_3;
				end
				
				3'b001: begin
					// Between s[2] and s[1]
					fr3 <= 1'b0;
					fr2 <= 1'b1;
					fr1 <= 1'b1;
					dfr <= (prev_state == BETWEEN_1_2) ? 1'b1 : 1'b0;
					prev_state <= BETWEEN_1_2;
				end
				
				3'b000: begin
					// Below s[1]
					fr3 <= 1'b1;
					fr2 <= 1'b1;
					fr1 <= 1'b1;
					dfr <= 1'b1;
					prev_state <= LOW;
				end
				
				default: begin
					// Default case to handle unexpected values, should not happen
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b0;
					dfr <= 1'b0;
					prev_state <= LOW;
				end
			endcase
		end
	end
endmodule

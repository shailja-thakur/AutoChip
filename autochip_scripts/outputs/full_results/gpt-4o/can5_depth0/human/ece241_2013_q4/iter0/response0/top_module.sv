module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

	reg [1:0] prev_state;
	reg [1:0] current_state;

	parameter LOW = 2'b00, 
	          MEDIUM_LOW = 2'b01, 
	          MEDIUM_HIGH = 2'b10, 
	          HIGH = 2'b11;
	          
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			fr1 <= 1'b1;
			fr2 <= 1'b1;
			fr3 <= 1'b1;
			dfr <= 1'b1;
			current_state <= LOW;
			prev_state <= LOW;
		end else begin
			prev_state <= current_state;
			
			case (s)
				3'b111: current_state <= HIGH;
				3'b011: current_state <= MEDIUM_HIGH;
				3'b001: current_state <= MEDIUM_LOW;
				default: current_state <= LOW;
			endcase
			
			case (current_state)
				HIGH: begin
					fr1 <= 1'b0;
					fr2 <= 1'b0;
					fr3 <= 1'b0;
					dfr <= 1'b0;
				end
				MEDIUM_HIGH: begin
					fr1 <= 1'b1;
					fr2 <= 1'b0;
					fr3 <= 1'b0;
					if (prev_state == MEDIUM_LOW || prev_state == LOW)
						dfr <= 1'b1;
					else
						dfr <= 1'b0;
				end
				MEDIUM_LOW: begin
					fr1 <= 1'b1;
					fr2 <= 1'b1;
					fr3 <= 1'b0;
					if (prev_state == LOW)
						dfr <= 1'b1;
					else
						dfr <= 1'b0;
				end
				LOW: begin
					fr1 <= 1'b1;
					fr2 <= 1'b1;
					fr3 <= 1'b1;
					dfr <= 1'b0;
				end
			endcase
		end
	end

endmodule

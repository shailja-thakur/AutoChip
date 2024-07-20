module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

	// State definitions
	reg [1:0] prev_state;
	reg [1:0] current_state;

	localparam LOW_LEVEL = 2'd0,
			  MID_LEVEL = 2'd1,
			  HIGH_LEVEL = 2'd2,
			  ABOVE_HIGH = 2'd3;
			  
	// State transitions based on sensor readings
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			prev_state <= LOW_LEVEL;
			current_state <= LOW_LEVEL;
		end else begin
			prev_state <= current_state;
			case (s)
				3'b000: current_state <= LOW_LEVEL;
				3'b001: current_state <= MID_LEVEL;
				3'b011: current_state <= HIGH_LEVEL;
				3'b111: current_state <= ABOVE_HIGH;
				default: current_state <= LOW_LEVEL;
			endcase
		end
	end
	
	// Outputs based on current state and previous state
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			fr3 <= 1'b1;
			fr2 <= 1'b1;
			fr1 <= 1'b1;
			dfr <= 1'b1;
		end else begin
			case (current_state)
				LOW_LEVEL: begin
					fr3 <= 1'b1;
					fr2 <= 1'b1;
					fr1 <= 1'b1;
					dfr <= 1'b0;
				end
				MID_LEVEL: begin
					fr3 <= 1'b0;
					fr2 <= 1'b1;
					fr1 <= 1'b1;
					dfr <= (prev_state == LOW_LEVEL);
				end
				HIGH_LEVEL: begin
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b1;
					dfr <= (prev_state == MID_LEVEL);
				end
				ABOVE_HIGH: begin
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b0;
					dfr <= (prev_state == HIGH_LEVEL);
				end
				default: begin
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b0;
					dfr <= 1'b0;
				end
			endcase
		end
	end

endmodule

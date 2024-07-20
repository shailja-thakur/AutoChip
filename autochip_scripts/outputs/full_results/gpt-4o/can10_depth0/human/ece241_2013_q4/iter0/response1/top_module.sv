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
	reg [1:0] state, next_state;
	localparam LOW   = 2'b00, // Below s[1]
               MID   = 2'b01, // Between s[2] and s[1]
               HIGH  = 2'b10, // Between s[3] and s[2]
               FULL  = 2'b11; // Above s[3]

	// State memory logic
	always @(posedge clk or posedge reset) begin
		if (reset) 
			state <= LOW; // Reset to LOW state
		else 
			state <= next_state;
	end

	// Next state logic
	always @(*) begin
		case (state)
			LOW: 
				if (s[1]) next_state = MID;
				else next_state = LOW;
				
			MID: 
				if (s[3]) next_state = FULL;
				else if (!s[1]) next_state = LOW;
				else next_state = MID;
				
			HIGH: 
				if (s[3]) next_state = FULL;
				else if (!s[2]) next_state = MID;
				else next_state = HIGH;
				
			FULL: 
				if (!s[3]) next_state = HIGH;
				else next_state = FULL;

			default: 
				next_state = LOW;
		endcase
	end

	// Output logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			fr3 <= 1'b1;
			fr2 <= 1'b1;
			fr1 <= 1'b1;
			dfr <= 1'b1;
		end
		else begin
			case (state)
				LOW: begin
					fr3 <= 1'b1;
					fr2 <= 1'b1;
					fr1 <= 1'b1;
					dfr <= 1'b1;
				end
				MID: begin
					fr3 <= 1'b0;
					fr2 <= 1'b1;
					fr1 <= 1'b1;
					dfr <= (next_state == MID) ? 1'b1 : 1'b0; // Open Supplemental flow valve if water level is rising
				end
				HIGH: begin
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b1;
					dfr <= (next_state == HIGH) ? 1'b1 : 1'b0; // Open Supplemental flow valve if water level is rising
				end
				FULL: begin
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b0;
					dfr <= 1'b0;
				end
			endcase
		end
	end

endmodule

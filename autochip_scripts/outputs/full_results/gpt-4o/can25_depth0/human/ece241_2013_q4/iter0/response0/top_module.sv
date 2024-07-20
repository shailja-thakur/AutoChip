module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

	// State Encoding
	parameter LOW = 2'b00, MID_LOW = 2'b01, MID_HIGH = 2'b10, HIGH = 2'b11;
	reg [1:0] current_state, next_state;

	// State Transition Logic
	always @(posedge clk or posedge reset) begin
		if (reset) 
			current_state <= LOW;
		else 
			current_state <= next_state;
	end

	// Next State Logic
	always @(*) begin
		case (current_state)
			LOW: begin
				if (s[1]) 
					next_state = MID_LOW;
				else 
					next_state = LOW;
			end
			MID_LOW: begin
				if (s[2]) 
					next_state = MID_HIGH;
				else if (!s[1]) 
					next_state = LOW;
				else 
					next_state = MID_LOW;
			end
			MID_HIGH: begin
				if (s[3]) 
					next_state = HIGH;
				else if (!s[2]) 
					next_state = MID_LOW;
				else 
					next_state = MID_HIGH;
			end
			HIGH: begin
				if (!s[3]) 
					next_state = MID_HIGH;
				else 
					next_state = HIGH;
			end
			default: 
				next_state = LOW;
		endcase
	end

	// Output Logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			fr3 <= 1;
			fr2 <= 1;
			fr1 <= 1;
			dfr <= 1;
		end else begin
			case (current_state)
				LOW: begin
					fr3 <= 1;
					fr2 <= 1;
					fr1 <= 1;
					dfr <= 0;
				end
				MID_LOW: begin
					fr3 <= 0;
					fr2 <= 1;
					fr1 <= 1;
					dfr <= (next_state == MID_HIGH);
				end
				MID_HIGH: begin
					fr3 <= 0;
					fr2 <= 0;
					fr1 <= 1;
					dfr <= (next_state == HIGH);
				end
				HIGH: begin
					fr3 <= 0;
					fr2 <= 0;
					fr1 <= 0;
					dfr <= 0;
				end
			endcase
		end
	end

endmodule

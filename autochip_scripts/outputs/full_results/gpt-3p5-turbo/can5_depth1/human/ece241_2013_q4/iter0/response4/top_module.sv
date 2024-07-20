module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

reg [1:0] state; // state variable to track water level
reg [1:0] prev_state; // previous state variable to track previous water level

// state definitions
parameter STOP_STATE = 2'b00; // all outputs asserted, no sensors asserted
parameter FR1_STATE = 2'b01; // sensors s[1] asserted
parameter FR2_STATE = 2'b10; // sensors s[1], s[2] asserted
parameter FR3_STATE = 2'b11; // all outputs de-asserted

always @(posedge clk) begin
	if(reset) begin
		state <= STOP_STATE;
		prev_state <= STOP_STATE;
	end
	else begin
		prev_state <= state; // update previous state

		// state transition logic
		case(state)
			STOP_STATE: begin
				if(s == 3'b111) // above s[3]
					state <= STOP_STATE;
				else if(s[2:1] == 2'b01) // between s[3] and s[2]
					state <= FR1_STATE;
				else if(s[1] == 1'b1) // between s[2] and s[1]
					state <= FR2_STATE;
				else // below s[1]
					state <= FR3_STATE;
			end
			FR1_STATE: begin
				if(s[1] == 1'b0) // previous level was lower than current level
					state <= FR2_STATE;
				else
					state <= FR1_STATE;
			end
			FR2_STATE: begin
				if(s[1] == 1'b0) // previous level was lower than current level
					state <= FR3_STATE;
				else if(s == 3'b111) // above s[3]
					state <= STOP_STATE;
				else
					state <= FR2_STATE;
			end
			FR3_STATE: begin
				if(s == 3'b111) // above s[3]
					state <= STOP_STATE;
				else if(s != 3'b111) // between s[3] and s[2]
					state <= FR1_STATE;
				else if(s[2:1] == 2'b01) // between s[2] and s[1]
					state <= FR2_STATE;
				else
					state <= FR3_STATE;
			end
		endcase
	end
end

// output assignment based on state
always @(state) begin
	case(state)
		STOP_STATE: begin
			fr3 <= 1'b1;
			fr2 <= 1'b1;
			fr1 <= 1'b1;
			dfr <= 1'b1;
		end
		FR1_STATE: begin
			fr3 <= 1'b0;
			fr2 <= 1'b0;
			fr1 <= 1'b1;
			dfr <= 1'b0;
		end
		FR2_STATE: begin
			fr3 <= 1'b0;
			fr2 <= 1'b1;
			fr1 <= 1'b1;
			dfr <= 1'b0;
		end
		FR3_STATE: begin
			fr3 <= 1'b1;
			fr2 <= 1'b1;
			fr1 <= 1'b1;
			dfr <= 1'b0;
		end
	endcase
end

endmodule

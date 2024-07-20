module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

	typedef enum reg [2:0] {
		LOW = 3'b000,
		MID_LOW = 3'b001,
		MID_HIGH = 3'b011,
		HIGH = 3'b111
	} state_t;

	reg [2:0] state, next_state;

	// State transition
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= LOW;
		else
			state <= next_state;
		end
	end

	// Next state logic
	always @(*) begin
		case (s)
			3'b111: next_state = HIGH;
			3'b011: next_state = MID_HIGH;
			3'b001: next_state = MID_LOW;
			default: next_state = LOW;
		endcase
	end

	// Output logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			fr3 <= 1;
			fr2 <= 1;
			fr1 <= 1;
			dfr <= 1;
		end
		else begin
			case (state)
				HIGH: begin
					fr3 <= 0;
					fr2 <= 0;
					fr1 <= 0;
					dfr <= 0;
				end
				MID_HIGH: begin
					fr3 <= 0;
					fr2 <= 0;
					fr1 <= 1;
					dfr <= 1;
				end
				MID_LOW: begin
					fr3 <= 0;
					fr2 <= 1;
					fr1 <= 1;
					dfr <= 0;
				end
				LOW: begin
					fr3 <= 1;
					fr2 <= 1;
					fr1 <= 1;
					dfr <= 1;
				end
			endcase
		end
	end

endmodule

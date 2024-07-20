module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

typedef enum logic [1:0] {
	LOW = 2'b00,
	MID_LOW = 2'b01,
	MID_HIGH = 2'b10,
	HIGH = 2'b11
} state_t;

state_t current_state, next_state;
logic dfr_set;

always_ff @(posedge clk or posedge reset) begin
	if (reset) begin
		current_state <= LOW;
		fr3 <= 1;
		fr2 <= 1;
		fr1 <= 1;
		dfr <= 1;
	end else begin
		current_state <= next_state;
		
		case (next_state)
			LOW: begin
				fr3 <= 1;
				fr2 <= 1;
				fr1 <= 1;
				dfr <= dfr_set;
			end
			MID_LOW: begin
				fr3 <= 0;
				fr2 <= 1;
				fr1 <= 1;
				dfr <= dfr_set;
			end
			MID_HIGH: begin
				fr3 <= 0;
				fr2 <= 0;
				fr1 <= 1;
				dfr <= dfr_set;
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

always_comb begin
	case (current_state)
		LOW: begin
			if (s[3])
				next_state = HIGH;
			else if (s[2])
				next_state = MID_HIGH;
			else if (s[1])
				next_state = MID_LOW;
			else
				next_state = LOW;
		end
		MID_LOW: begin
			if (s[3])
				next_state = HIGH;
			else if (s[2])
				next_state = MID_HIGH;
			else if (s[1])
				next_state = MID_LOW;
			else
				next_state = LOW;
		end
		MID_HIGH: begin
			if (s[3])
				next_state = HIGH;
			else if (s[2])
				next_state = MID_HIGH;
			else if (s[1])
				next_state = MID_LOW;
			else
				next_state = LOW;
		end
		HIGH: begin
			if (s[3])
				next_state = HIGH;
			else if (s[2])
				next_state = MID_HIGH;
			else if (s[1])
				next_state = MID_LOW;
			else
				next_state = LOW;
		end
		default: next_state = LOW;
	endcase
	
	// Logic to set dfr if the water level is increasing
	if (next_state > current_state)
		dfr_set = 1;
	else
		dfr_set = 0;
end

endmodule

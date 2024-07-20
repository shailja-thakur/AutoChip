module top_module (
	input clk,
	input reset,
	input x,
	output reg z,
	output reg [2:0] y
);

reg [2:0] next_y;

// state assignment
parameter S_000 = 3'b000;
parameter S_001 = 3'b001;
parameter S_010 = 3'b010;
parameter S_011 = 3'b011;
parameter S_100 = 3'b100;

// state signals
reg [2:0] present_state;
reg [2:0] next_state;

always @(posedge clk or posedge reset) begin
	if (reset)
		present_state <= S_000;
	else
		present_state <= next_state;
end

always @(*) begin
	case (present_state)
		S_000: begin
			if (x)
				next_state = S_001;
			else
				next_state = S_000;
		end
		S_001: begin
			if (x)
				next_state = S_100;
			else
				next_state = S_001;
		end
		S_010: begin
			if (x)
				next_state = S_001;
			else
				next_state = S_010;
		end
		S_011: begin
			if (x)
				next_state = S_010;
			else
				next_state = S_001;
		end
		S_100: begin
			if (x)
				next_state = S_100;
			else
				next_state = S_011;
		end
	endcase
end

always @(posedge clk) begin
	case (present_state)
		S_011: z <= 1;
		S_100: z <= 1;
		default: z <= 0;
	endcase
end

assign y = present_state;

endmodule

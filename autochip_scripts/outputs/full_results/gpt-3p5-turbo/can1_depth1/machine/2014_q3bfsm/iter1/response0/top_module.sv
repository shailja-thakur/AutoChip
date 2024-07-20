module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 3'b001;
	else
		state <= next_state;
end

always @* begin
	case (state)
		3'b000: begin
			if (x)
				next_state = 3'b001;
			else
				next_state = 3'b000;
		end
		3'b001: begin
			if (x)
				next_state = 3'b100;
			else
				next_state = 3'b001;
		end
		3'b010: begin
			if (x)
				next_state = 3'b001;
			else
				next_state = 3'b010;
		end
		3'b011: begin
			if (x)
				next_state = 3'b100;
			else
				next_state = 3'b011;
		end
		3'b100: begin
			if (x)
				next_state = 3'b010;
			else
				next_state = 3'b100;
		end
		default: begin
			if (x)
				next_state = 3'b100;
			else
				next_state = 3'b101;
		end
	endcase
end

always @* begin
	if (state == 3'b110 || state == 3'b101)
		z = 1;
	else
		z = 0;
end

endmodule

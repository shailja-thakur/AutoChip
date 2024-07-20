module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [1:0] state;
reg [1:0] next_state;
reg [1:0] z;

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= 0;
	else
		state <= next_state;
end

always @* begin
	next_state = state;
	case (state)
		0: begin
			if (areset)
				next_state = 0;
			else if (x)
				next_state = 1;
			else
				next_state = 0;
		end
		1: begin
			if (x)
				next_state = 1;
			else
				next_state = 2;
		end
		2: begin
			if (x)
				next_state = 3;
			else
				next_state = 2;
		end
		3: begin
			next_state = 0;
		end
	endcase
end

always @(posedge clk) begin
	if (areset)
		z <= 0;
	else if (state == 2)
		z <= ~z;
	end
end

endmodule

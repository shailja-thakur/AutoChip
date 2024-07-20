module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

reg [1:0] state;
reg [1:0] next_state;

initial begin
	state = 2'b00;
end

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= 2'b00;
	else
		state <= next_state;
end

always @(state or x) begin
	case (state)
		2'b00: begin
			if (x)
				next_state = 2'b01;
			else
				next_state = 2'b00;
		end
		2'b01: begin
			if (x)
				next_state = 2'b10;
			else
				next_state = 2'b01;
		end
		2'b10: begin
			if (x)
				next_state = 2'b10;
			else
				next_state = 2'b01;
		end
	endcase
end

always @(state) begin
	case (state)
		2'b00: z = 1'b0;
		2'b01: z = 1'b1;
		2'b10: z = 1'b0;
	endcase
end

endmodule

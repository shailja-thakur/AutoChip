module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);

reg q;
reg[1:0] state;

always @(posedge clk) begin
	state <= state[0];
	case (state)
		0: begin
			if (a == 0 && b == 0)
				state <= 0;
			else if (a == 1 && b == 0)
				state <= 1;
			else if (a == 0 && b == 1)
				state <= 2;
			else if (a == 1 && b == 1)
				state <= 3;
		end
		1: begin
			state <= 2;
		end
		2: begin
			state <= 3;
		end
		3: begin
			state <= 0;
		end
	endcase
end

always @(posedge clk) begin
	case (state)
		0: begin
			q <= 0;
		end
		1: begin
			q <= 1;
		end
		2: begin
			q <= 0;
		end
		3: begin
			q <= 1;
		end
	endcase
end

assign state = q;
endmodule

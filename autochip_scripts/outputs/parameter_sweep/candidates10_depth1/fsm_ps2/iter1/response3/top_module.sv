module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
	end else begin
		state <= next_state;
	end
end

always @(state, in) begin
	case (state)
		0: begin
			if (in[3] == 1) begin
				next_state = 1;
			end else begin
				next_state = 0;
			end
		end
		1: begin
			if (in[3] == 1) begin
				next_state = 2;
			end else begin
				next_state = 0;
			end
		end
		2: begin
			if (in[3] == 1) begin
				next_state = 3;
			end else begin
				next_state = 0;
			end
		end
		3: begin
			next_state = 0;
		end
	endcase
end

assign done = (state == 3);

endmodule

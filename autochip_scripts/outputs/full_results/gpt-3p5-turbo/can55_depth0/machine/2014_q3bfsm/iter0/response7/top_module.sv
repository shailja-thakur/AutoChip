module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

reg [2:0] state, next_state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 3'b001; // initializing state to A
	end else begin
		state <= next_state;
	end
end

always @* begin
	case (state)
		3'b000: begin
			if (x) begin
				next_state = 3'b001; // next state is B
			end else begin
				next_state = 3'b000; // next state is A
			end
		end
		3'b001: begin
			if (x) begin
				next_state = 3'b100; // next state is E
			end else begin
				next_state = 3'b001; // next state is B
			end
		end
		3'b010: begin
			if (x) begin
				next_state = 3'b001; // next state is B
			end else begin
				next_state = 3'b010; // next state is C
			end
		end
		3'b011: begin
			if (x) begin
				next_state = 3'b010; // next state is C
			end else begin
				next_state = 3'b001; // next state is B
			end
		end
		3'b100: begin
			if (x) begin
				next_state = 3'b100; // next state is E
			end else begin
				next_state = 3'b011; // next state is D
			end
		end
		3'b101: begin
			if (x) begin
				next_state = 3'b100; // next state is E
			end else begin
				next_state = 3'b100; // next state is E
			end
		end
		3'b110: begin
			if (x) begin
				next_state = 3'b011; // next state is D
			end else begin
				next_state = 3'b011; // next state is D
			end
		end
		3'b111: begin
			if (x) begin
				next_state = 3'b100; // next state is E
			end else begin
				next_state = 3'b010; // next state is C
			end
		end
	endcase
end

always @(state) begin
	if (state == 3'b100 || state == 3'b101) begin
		z <= 1; // output is high when state is D or E
	else
		z <= 0;
	end
end

endmodule

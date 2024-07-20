module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 3'b001; // initialize state to A
	end else begin
		state <= next_state;
	end
end

always @* begin
	case (state)
		3'b000: begin // state A
			if (x) begin
				next_state = 3'b010; // transition to state B
			end else begin
				next_state = 3'b000; // stay in state A
			end
		end
		3'b001: begin // state B
			if (x) begin
				next_state = 3'b100; // transition to state E
			end else begin
				next_state = 3'b001; // stay in state B
			end
		end
		3'b010: begin // state C
			if (x) begin
				next_state = 3'b001; // transition to state B
			end else begin
				next_state = 3'b010; // stay in state C
			end
		end
		3'b011: begin // state D
			if (x) begin
				next_state = 3'b010; // transition to state C
			end else begin
				next_state = 3'b011; // stay in state D
			end
		end
		3'b100: begin // state E
			if (x) begin
				next_state = 3'b100; // stay in state E
			end else begin
				next_state = 3'b011; // transition to state D
			end
		end
		default: next_state = 3'b000; // default transition to state A
	endcase
end

always @(posedge clk) begin
	if (state == 3'b100 || state == 3'b101) begin // state D or E
		z <= 1'b1; // output is high
	end else begin
		z <= 1'b0; // output is low
	end
end

endmodule

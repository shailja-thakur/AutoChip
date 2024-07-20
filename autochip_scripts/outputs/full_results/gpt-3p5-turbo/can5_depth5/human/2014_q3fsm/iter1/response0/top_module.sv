module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [1:0] state;
reg [1:0] nextState;
reg [2:0] w_count;
wire w_in_two_clock_cycles;

parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= A;
		w_count <= 3'b000;
	end else begin
		state <= nextState;
	end
end

always @(state, s, w) begin
	case (state)
		A: begin
			if (s == 1'b1) begin
				nextState <= B;
			end else begin
				nextState <= A;
			end
		end
		B: begin
			if (w == 1'b1) begin
				nextState <= C;
			end else begin
				nextState <= A;
			end
		end
		C: begin
			nextState <= A;
		end
	endcase
end

assign w_in_two_clock_cycles = (w_count == 2'b10) ? 1'b1 : 1'b0;

always @(posedge clk) begin
	if (state == C) begin
		if (w_in_two_clock_cycles) begin
			z <= 1'b1;
		end else begin
			z <= 1'b0;
		end
	end else begin
		z <= 1'b0;
	end
	w_count <= {w_count[1:0], w};
end

endmodule

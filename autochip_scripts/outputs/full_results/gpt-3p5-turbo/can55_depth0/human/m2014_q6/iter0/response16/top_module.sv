module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state;
reg [1:0] next_state;
reg next_output;

parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;
parameter F = 3'b101;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= A;
	end else begin
		state <= next_state;
	end
end

always @(state, w) begin
	case(state)
		A: begin
			if (w) begin
				next_state <= A;
				next_output <= 0;
			end else begin
				next_state <= B;
				next_output <= 0;
			end
		end
		B: begin
			if (w) begin
				next_state <= D;
				next_output <= 1;
			end else begin
				next_state <= C;
				next_output <= 0;
			end
		end
		C: begin
			if (w) begin
				next_state <= D;
				next_output <= 1;
			end else begin
				next_state <= E;
				next_output <= 0;
			end
		end
		D: begin
			if (w) begin
				next_state <= A;
				next_output <= 1;
			end else begin
				next_state <= F;
				next_output <= 0;
			end
		end
		E: begin
			if (w) begin
				next_state <= D;
				next_output <= 1;
			end else begin
				next_state <= E;
				next_output <= 1;
			end
		end
		F: begin
			if (w) begin
				next_state <= D;
				next_output <= 1;
			end else begin
				next_state <= C;
				next_output <= 1;
			end
		end
	endcase
end

always @(posedge clk) begin
	if (reset) begin
		z <= 0;
	end else begin
		z <= next_output;
	end
end

endmodule

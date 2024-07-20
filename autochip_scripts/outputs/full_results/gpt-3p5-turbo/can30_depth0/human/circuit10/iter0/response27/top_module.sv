module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);

reg q, state;
reg next_q, next_state;

parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;
parameter S3 = 2'b11;

always @(posedge clk) begin
	case(state)
		S0: begin
			if(a & b) begin
				next_q = 1'b1;
				next_state = S0;
			end else if(a) begin
				next_q = 1'b1;
				next_state = S2;
			end else begin
				next_q = 1'b0;
				next_state = S1;
			end
		end
		S1: begin
			if(a & b) begin
				next_q = 1'b0;
				next_state = S0;
			end else if(a) begin
				next_q = 1'b1;
				next_state = S2;
			end else begin
				next_q = 1'b0;
				next_state = S1;
			end
		end
		S2: begin
			if(a & b) begin
				next_q = 1'b0;
				next_state = S0;
			end else if(a) begin
				next_q = 1'b1;
				next_state = S2;
			end else begin
				next_q = 1'b0;
				next_state = S1;
			end
		end
		S3: begin
			if(a & b) begin
				next_q = 1'b0;
				next_state = S0;
			end else if(a) begin
				next_q = 1'b1;
				next_state = S2;
			end else begin
				next_q = 1'b0;
				next_state = S1;
			end
		end
	endcase
end

always @(posedge clk) begin
	q <= next_q;
	state <= next_state;
end

assign q = next_q;
assign state = next_state;

endmodule

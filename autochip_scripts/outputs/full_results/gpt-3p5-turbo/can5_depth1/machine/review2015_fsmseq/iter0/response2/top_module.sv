module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting
);

reg [3:0] state;
wire next_state;

parameter S = 4'b0000;
parameter S1 = 4'b0001;
parameter S11 = 4'b0010;
parameter S110 = 4'b0011;
parameter Done = 4'b0100;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= S;
	end else begin
		state <= next_state;
	end
end

always @(*) begin
	case (state)
		S: begin
			if (data) begin
				next_state = S1;
			end else begin
				next_state = S;
			end
		end
		S1: begin
			if (data) begin
				next_state = S11;
			end else begin
				next_state = S;
			end
		end
		S11: begin
			if (data) begin
				next_state = S11;
			end else begin
				next_state = S110;
			end
		end
		S110: begin
			if (data) begin
				next_state = Done;
			end else begin
				next_state = S;
			end
		end
		Done: begin
			next_state = Done;
		end
	endcase
end

assign start_shifting = (state == Done);

endmodule

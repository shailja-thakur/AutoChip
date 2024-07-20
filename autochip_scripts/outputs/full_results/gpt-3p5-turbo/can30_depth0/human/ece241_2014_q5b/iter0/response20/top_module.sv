module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [1:0] state, next_state;
reg z_reg;
	
parameter A = 2'b00;
parameter B = 2'b01;

always @(posedge clk or posedge areset) begin
	if(areset) begin
		state <= A;
		z_reg <= 0;
	end else begin
		state <= next_state;
		z_reg <= (state == B) ? 1 : 0;
	end
end

always @(*) begin
	case(state)
		A: begin
			if(x)
				next_state = B;
			else
				next_state = A;
		end
		B: begin
			if(x)
				next_state = B;
			else
				next_state = B;
		end
		default: next_state = A;
	endcase
end

assign z = z_reg;

endmodule

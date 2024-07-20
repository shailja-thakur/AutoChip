module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

reg [2:0] state;
reg [2:0] next_state;

parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;
parameter S3 = 3'b011;

always @(posedge clk or negedge aresetn) begin
	if (~aresetn) begin
		state <= S0;
	end else begin
		state <= next_state;
	end
end

always @* begin
	case(state)
		S0: begin
			if (x == 1'b1)
				next_state = S1;
			else
				next_state = S0;
		end
		S1: begin
			if (x == 1'b0)
				next_state = S2;
			else
				next_state = S1;
		end
		S2: begin
			if (x == 1'b1)
				next_state = S3;
			else
				next_state = S0;
		end
		S3: begin
			next_state = S0;
		end
	endcase
end

always @(posedge clk or negedge aresetn) begin
	if (~aresetn) begin
		z <= 1'b0;
	end else begin
		if (state == S3)
			z <= 1'b1;
		else
			z <= 1'b0;
	end
end

endmodule

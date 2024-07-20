module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

reg [2:0] state;
parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;

always @(negedge aresetn or posedge clk)begin
	if(!aresetn)begin
		state <= S0;
		z <= 0;
	end else begin
		case(state)
			S0: begin
				if(x == 1'b1)
					state <= S1;
				else
					state <= S0;
			end
			S1: begin
				if(x == 1'b0)
					state <= S2;
				else
					state <= S0;
			end
			S2: begin
				if(x == 1'b1) begin
					state <= S1;
					z <= 1;
				end else
					state <= S0;
			end
		endcase
	end
end

endmodule

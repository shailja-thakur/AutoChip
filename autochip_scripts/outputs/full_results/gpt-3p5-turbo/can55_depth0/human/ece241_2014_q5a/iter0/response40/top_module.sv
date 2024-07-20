module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	
reg [2:0] state;
reg z;
	
parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;
	
always @(posedge clk or negedge areset) begin
	if (areset) begin
		state <= S0;
		z <= 1'b0;
	end else begin
		case (state)
			S0: begin
				if (x) begin
					state <= S1;
					z <= 1'b1;
				end
			end
			S1: begin
				if (x) begin
					state <= S1;
					z <= ~z;
				end else begin
					state <= S2;
					z <= ~z;
				end
			end
			S2: begin
				if (x) begin
					state <= S2;
					z <= ~z;
				end else begin
					state <= S0;
					z <= ~z;
				end
			end
			default: state <= S0;
		endcase
	end
end 

endmodule

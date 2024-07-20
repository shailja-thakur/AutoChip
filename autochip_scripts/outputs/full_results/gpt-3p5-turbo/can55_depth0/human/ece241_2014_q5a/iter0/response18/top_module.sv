module top_module (
	input clk,
	input areset,
	input x,
	output z
);
reg [2:0] state;
reg z;
reg tmp;

parameter [2:0] RESET=0;
parameter [2:0] CHECK=1;
parameter [2:0] NEGATE=2;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= RESET;
		z <= 0;
	end else begin
		case (state)
			RESET: begin
				if (!areset) begin
					state <= CHECK;
				end
			end
			CHECK: begin
				state <= NEGATE;
			end
			NEGATE: begin
				state <= CHECK;
			end
		endcase
	end
end

always @(posedge clk) begin
	if (state == CHECK) begin
		tmp <= !x;
	end else if (state == NEGATE) begin
		tmp <= tmp + 1;
	end
end

always @(posedge clk) begin
	if (state == CHECK) begin
		z <= tmp;
	end
end

endmodule

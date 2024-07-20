module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [3:0] state;

// State definitions
parameter S0 = 4'b0000;
parameter S1 = 4'b0001;

always @(posedge clk or negedge areset) begin
	if (areset == 0) begin
		state <= S0;
	end else begin
		case (state)
			S0: if (areset == 1) begin
					state <= S1;
				end
			S1: if (x == 1) begin
					state <= S0;
				end
				else begin
					state <= S1;
				end
			default: state <= S0;
		endcase
	end
end

// Output assignment
assign z = (state == S0) ? ~x + 1 : x;

endmodule

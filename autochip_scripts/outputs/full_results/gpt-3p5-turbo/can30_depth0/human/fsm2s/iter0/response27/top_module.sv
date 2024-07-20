module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

reg [1:0] state;
parameter OFF = 2'b00;
parameter ON = 2'b01;

always @(posedge clk) begin
	if (reset) begin
		state <= OFF;
	end else begin
		case (state)
			OFF: begin
				if (j) begin
					state <= ON;
				end
			end
			
			ON: begin
				if (!k) begin
					state <= ON;
				end else begin
					state <= OFF;
				end
			end
		endcase
	end
end

always @(*) begin
	case (state)
		OFF: begin
			out = 1'b0;
		end
		
		ON: begin
			out = 1'b1;
		end
	endcase
end

endmodule

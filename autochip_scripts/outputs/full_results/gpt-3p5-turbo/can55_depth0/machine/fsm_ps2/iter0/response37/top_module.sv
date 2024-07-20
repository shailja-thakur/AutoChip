module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [1:0] state;
reg done;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 2'd0;
		done <= 0;
	end else begin
		case (state)
			2'd0: begin
				if (in[2]) begin
					state <= 2'd1;
				end
			end
			2'd1: begin
				state <= 2'd2;
			end
			2'd2: begin
				state <= 2'd3;
			end
			2'd3: begin
				state <= 2'd0;
			end
		endcase
		
		if (state == 2'd3 && in[2]) begin
			done <= 1;
		end else begin
			done <= 0;
		end
	end
end

endmodule

module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [1:0] state;
  
always @(posedge clk) begin
	if (reset == 1'b1) begin
		state <= 2'b10;
	end else begin
		case (state)
			2'b10: begin
				if (in == 1'b0) begin
					state <= 2'b01;
				end else begin
					state <= 2'b10;
				end
			end
			
			2'b01: begin
				if (in == 1'b0) begin
					state <= 2'b10;
				end else begin
					state <= 2'b01;
				end
			end
		endcase
	end
end

always @(state) begin
	case (state)
		2'b10: begin
			out = 1'b1;
		end
		
		2'b01: begin
			out = 1'b0;
		end
	endcase
end
  
endmodule

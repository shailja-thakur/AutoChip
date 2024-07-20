module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [1:0] state;
reg out;

always @(posedge clk, posedge reset) begin
	if (reset) begin
		state <= 2'b10;
		out <= 1'b1;
	end else begin
		case(state)
			2'b10: begin // State B
				if(in)
					begin
						state <= 2'b10;
						out <= 1'b1;
					end
				else
					begin
						state <= 2'b01;
						out <= 1'b1;
					end
			end
				
			2'b01: begin // State A
				if(in)
					begin
						state <= 2'b01;
						out <= 1'b0;
					end
				else
					begin
						state <= 2'b10;
						out <= 1'b0;
					end
			end
		endcase
	end
end

endmodule

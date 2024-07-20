module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	reg [1:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 2'b00; //A
		end else begin
			case(state)
				2'b00: begin //A
					if (j) begin
						state <= 2'b01; //B
					end
				end
				2'b01: begin //B
					if (k) begin
						state <= 2'b00; //A
					end
				end
			endcase
		end
	end
	
	always @(state) begin
		if (state == 2'b01) begin //B
			out <= 1'b1;
		end else begin //A
			out <= 1'b0;
		end
	end

endmodule

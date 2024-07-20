module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	reg [3:0] state;
	always @(posedge clk) begin
		if(reset) begin
			state <= 4'bS;
		end
		else begin
			case(state)
				4'bS: begin
					if(data) begin
						state <= 4'bS1;
					end
					else begin
						state <= 4'bS;
					end
				end
				4'bS1: begin
					if(data) begin
						state <= 4'bS11;
					end
					else begin
						state <= 4'bS;
					end
				end
				4'bS11: begin
					if(data) begin
						state <= 4'bS11;
					end
					else begin
						state <= 4'bS110;
					end
				end
				4'bS110: begin
					if(data) begin
						state <= 4'bDone;
					end
					else begin
						state <= 4'bS;
					end
				end
				4'bDone: begin
					state <= 4'bDone;
				end
			endcase
		end
	end

	assign start_shifting = (state == 4'bDone);

endmodule

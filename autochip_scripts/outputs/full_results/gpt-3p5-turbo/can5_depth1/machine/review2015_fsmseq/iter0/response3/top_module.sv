module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);
	
	reg [1:0] state;
	
	always @(posedge clk) begin
		if (reset) begin
			state <= 2'b00; // initial state (S)
		end else begin
			case (state)
				2'b00: begin // S
					if (data) begin
						state <= 2'b01; // S1
					end
				end
				2'b01: begin // S1
					if (data) begin
						state <= 2'b10; // S11
					end else begin
						state <= 2'b00; // S
					end
				end
				2'b10: begin // S11
					if (data) begin
						state <= 2'b10; // S11
					end else begin
						state <= 2'b11; // S110
					end
				end
				2'b11: begin // S110
					if (data) begin
						state <= 2'b10; // Done
					end else begin
						state <= 2'b00; // S
					end
				end
			endcase
		end
	end
	
	always@(state) begin
		if (state == 2'b10) begin
			start_shifting <= 1'b1; // output high when state is Done
		end else begin
			start_shifting <= 1'b0;
		end
	end
	
endmodule

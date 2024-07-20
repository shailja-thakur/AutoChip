module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	reg [3:0] state, next_state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 4'b0000;
		end else begin
			state <= next_state;
		end
	end
	
	always @(state or data) begin
		case (state)
			4'b0000: begin
				if (data) begin
					next_state = 4'b0001;
				end else begin
					next_state = 4'b0000;
				end
			end
			
			4'b0001: begin
				if (data) begin
					next_state = 4'b0011;
				end else begin
					next_state = 4'b0000;
				end
			end
			
			4'b0011: begin
				if (data) begin
					next_state = 4'b0011;
				end else begin
					next_state = 4'b0110;
				end
			end
			
			4'b0110: begin
				if (data) begin
					next_state = 4'b1111;
				end else begin
					next_state = 4'b0000;
				end
			end
			
			4'b1111: begin
				next_state = 4'b1111;
			end
		endcase
	end
	
	assign start_shifting = (state == 4'b1111);

endmodule

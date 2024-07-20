module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [3:0] state;
	reg signal_detected;
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 4'b0000;
			start_shifting <= 0;
			signal_detected <= 0;
		end
		else begin
			case(state)
				4'b0000: begin
					if (data)
						state <= 4'b0001;
					else
						state <= 4'b0000;
				end
				4'b0001: begin
					if (data)
						state <= 4'b0010;
					else
						state <= 4'b0000;
				end
				4'b0010: begin
					if (data)
						state <= 4'b0011;
					else
						state <= 4'b0000;
				end
				4'b0011: begin
					if (data)
						state <= 4'b0100;
					else
						state <= 4'b0000;
				end
				4'b0100: begin
					if (data) begin
						state <= 4'b0100;
						signal_detected <= 1;
					end
					else begin
						state <= 4'b0000;
						signal_detected <= 0;
					end
				end
				default: begin
					state <= 4'b0000;
					signal_detected <= 0;
				end
			endcase
		end
	end
	
	always @(posedge clk) begin
		if (reset)
			start_shifting <= 0;
		else if (signal_detected)
			start_shifting <= 1;
	end
endmodule

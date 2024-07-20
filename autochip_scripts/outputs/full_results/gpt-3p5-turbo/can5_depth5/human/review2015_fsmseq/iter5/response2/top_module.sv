module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [3:0] state;
	// Create a temporary signal to hold the current value of the input data
	reg prev_data;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 4'b0000;
			start_shifting <= 0;
			prev_data <= 0;
		end
		else begin
			case(state)
				4'b0000: begin
					if (data && !prev_data) state <= 4'b0001;
				end
				4'b0001: begin
					if (data && !prev_data) state <= 4'b0010;
					else if (!data && prev_data) state <= 4'b0000;
				end
				4'b0010: begin
					if (data && !prev_data) state <= 4'b0011;
					else if (!data && prev_data) state <= 4'b0000;
				end
				4'b0011: begin
					if (data && !prev_data) begin
						state <= 4'b0100;
						start_shifting <= 1;
					end
					else if (!data && prev_data) state <= 4'b0000;
				end
				4'b0100: begin
					if (!data && prev_data) state <= 4'b0000;
				end
				default: state <= 4'b0000;
			endcase
			prev_data <= data;
		end
	end
endmodule

module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	// Internal signals
	reg [2:0] state;
	reg start_shifting;

	// Sequential logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b0;
			start_shifting <= 0;
		end else begin
			case (state)
				3'b000: begin
					if (data == 1'b1)
						state <= 3'b001;
					else
						state <= 3'b000;
				end
				3'b001: begin
					if (data == 1'b1)
						state <= 3'b011;
					else
						state <= 3'b000;
				end
				3'b011: begin
					if (data == 1'b0)
						state <= 3'b100;
					else
						state <= 3'b000;
				end
				3'b100: begin
					if (data == 1'b1) begin
						state <= 3'b000;
						start_shifting <= 1;
					end else begin
						state <= 3'b101;
						start_shifting <= 0;
					end
				end
				3'b101: begin
					state <= 3'b000;
					start_shifting <= 0;
				end
			endcase
		end
	end
	
endmodule

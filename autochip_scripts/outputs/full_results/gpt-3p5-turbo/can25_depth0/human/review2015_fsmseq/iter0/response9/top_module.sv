module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	reg [3:0] state;
	reg start_shifting;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 4'b0000;
			start_shifting <= 0;
		end else begin
			case(state)
				4'b0000: begin // Initial state
					if (data) begin
						state <= 4'b0001;
					end else begin
						state <= 4'b0000;
					end
				end
				4'b0001: begin // Waiting for 1
					if (data) begin
						state <= 4'b0010;
					end else begin
						state <= 4'b0001;
					end
				end
				4'b0010: begin // Waiting for 1
					if (data) begin
						state <= 4'b0011;
					end else begin
						state <= 4'b0001;
					end
				end
				4'b0011: begin // Waiting for 0
					if (data) begin
						state <= 4'b0100;
					end else begin
						state <= 4'b0001;
					end
				end
				4'b0100: begin // Waiting for 1
					if (data) begin
						start_shifting <= 1;
						state <= 4'b0100;
					end else begin
						state <= 4'b0100;
					end
				end
			endcase
		end
	end
endmodule

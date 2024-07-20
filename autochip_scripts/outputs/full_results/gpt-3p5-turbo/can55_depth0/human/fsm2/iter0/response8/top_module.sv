module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

	reg out;
	reg [1:0] state;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b0;
		end else begin
			case (state)
				2'b00: begin // OFF state
					if (j) begin
						state <= 2'b01; // transition to ON state
						out <= 1'b0; // output is 0
					end else begin
						state <= 2'b00; // stay in OFF state
						out <= 1'b0; // output is 0
					end
				end
				2'b01: begin // ON state
					if (k) begin
						state <= 2'b00; // transition to OFF state
						out <= 1'b1; // output is 1
					end else begin
						state <= 2'b01; // stay in ON state
						out <= 1'b1; // output is 1
					end
				end
			endcase
		end
	end
	
endmodule

module top_module (
	input clk,
	input areset,
	input x,
	output z
);

// Define states
reg [1:0] state;

// Define outputs
assign z = (state == 2'b10) ? 1'b0 : 1'b1;

// Define next state and output logic
always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= 2'b00;
	end else begin
		case (state)
			2'b00: begin
				if (x) begin
					state <= 2'b01;
				end else begin
					state <= 2'b00;
				end
			end
			
			2'b01: begin
				if (x) begin
					state <= 2'b00;
				end else begin
					state <= 2'b01;
				end
			end
		endcase
	end
end

endmodule

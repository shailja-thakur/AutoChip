module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [1:0] state;
reg temp_z;

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= 2'b00;
	else
		state <= next_state;
end

always @* begin
	case(state)
		2'b00: begin
			if (x)
				next_state = 2'b01;
			else
				next_state = 2'b00;

			temp_z = 1'b0;
		end
		2'b01: begin
			if (x)
				next_state = 2'b00;
			else
				next_state = 2'b01;

			temp_z = 1'b1;
		end
	endcase
end

assign z = temp_z;

endmodule

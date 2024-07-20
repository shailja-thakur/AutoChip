module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [1:0] state;
reg z_reg;
wire [1:0] next_state;
wire next_z;

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= 2'b00;
	else
		state <= next_state;
end

assign z = z_reg;

// transition and output logic
always @*
begin
case(state)
	2'b00:
	begin
		if (x)
		begin
			next_state = 2'b10;
			next_z = 1'b1;
		end
		else
		begin
			next_state = 2'b00;
			next_z = 1'b0;
		end
	end
	2'b10:
	begin
		if (x)
		begin
			next_state = 2'b10;
			next_z = 1'b0;
		end
		else
		begin
			next_state = 2'b10;
			next_z = 1'b1;
		end
	end
	default:
	begin
		next_state = 2'b10;
		next_z = 1'b1;
	end
endcase

end

always @(posedge clk or posedge areset) begin
	if (areset)
		z_reg <= 1'b0;
	else
		z_reg <= next_z;
end

endmodule

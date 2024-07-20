module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [2:0] state;
reg [31:0] z_reg;
wire x;

// State definitions
parameter S0 = 3'b000;
parameter S1 = 3'b001;

// Next state and output logic
always @(posedge clk or negedge areset) begin
	if (areset == 0) begin
		state <= S0;
		z_reg <= 0;
	end else begin
		case (state)
			S0: begin
				state <= S1;
				z_reg <= x;
			end
			S1: begin
				state <= S1;
				z_reg <= ~x + 1;
			end
		endcase
	end
end

// Output assignment
assign z = z_reg;

endmodule

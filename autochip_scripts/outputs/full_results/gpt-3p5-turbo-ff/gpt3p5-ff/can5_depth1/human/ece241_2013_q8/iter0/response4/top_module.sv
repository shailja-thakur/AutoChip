module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

reg [1:0] state;
wire x_seq;
reg z_reg;

// detect the sequence "101"
assign x_seq = (state == 0 && x) || (state == 1 && !x) || (state == 2 && x);

// synchronous reset
always @(posedge clk or negedge aresetn)
begin
	if (!aresetn)
		state <= 0;
	else
		state <= x_seq ? state + 1 : 0;
end

// output logic
always @(posedge clk)
begin
	if (!aresetn)
		z_reg <= 0;
	else if (state == 2)
		z_reg <= 1;
else
		z_reg <= 0;
end

// output assignment
assign z = z_reg;

endmodule

module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
wire [1:0] next_state;

assign next_state = (state == 2'b00 && in) ? 2'b01 :
                   (state == 2'b00 && !in) ? 2'b00 :
                   (state == 2'b01 && in) ? 2'b01 :
                   (state == 2'b01 && !in) ? 2'b10 :
                   (state == 2'b10 && in) ? 2'b11 :
                   (state == 2'b10 && !in) ? 2'b00 :
                   (state == 2'b11 && in) ? 2'b01 :
                   (state == 2'b11 && !in) ? 2'b10 : 2'b00;

always @(posedge clk or posedge areset)
begin
	if (areset)
		state <= 2'b00;
	else
		state <= next_state;
end

assign out = (state == 2'b11) ? 1'b1 : 1'b0;

endmodule

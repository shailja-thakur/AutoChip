module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [1:0] state;
wire out;

always@(posedge clk or posedge reset)
    if(reset)
        state <= 2'b01;
    else if(state == 2'b00 && in)
        state <= 2'b10;
    else if(state == 2'b00 && ~in)
        state <= 2'b01;
    else if(state == 2'b10 && in)
        state <= 2'b10;
    else if(state == 2'b10 && ~in)
        state <= 2'b01;
    else if(state == 2'b01 && in)
        state <= 2'b10;
    else if(state == 2'b01 && ~in)
        state <= 2'b01;

assign out = (state == 2'b00) ? 1'b0 : 1'b1;

endmodule

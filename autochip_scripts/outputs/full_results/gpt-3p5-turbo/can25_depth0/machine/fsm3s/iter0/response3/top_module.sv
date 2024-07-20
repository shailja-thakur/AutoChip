module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [1:0] state;
reg out;

always @(posedge clk or posedge reset)
    if (reset)
        state <= 2'b00;
    else
        case (state)
            2'b00: begin
                if (in)
                    state <= 2'b01;
            end
            2'b01: begin
                if (in)
                    state <= 2'b01;
                else
                    state <= 2'b10;
            end
            2'b10: begin
                if (in)
                    state <= 2'b11;
                else
                    state <= 2'b00;
            end
            2'b11: begin
                if (in)
                    state <= 2'b01;
                else
                    state <= 2'b10;
            end
        endcase

always @(state)
    if (state == 2'b11)
        out = 1'b1;
    else
        out = 1'b0;

endmodule

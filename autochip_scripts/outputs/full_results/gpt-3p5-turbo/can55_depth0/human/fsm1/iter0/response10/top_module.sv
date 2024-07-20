module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
reg out;

always @(posedge clk or posedge areset)
    if (areset)
        state <= 2'b1;
    else
        case (state)
            2'b00: // A
                if (in)
                    state <= 2'b01; // B
                else
                    state <= 2'b00; // A
            2'b01: // B
                if (in)
                    state <= 2'b01; // B
                else
                    state <= 2'b00; // A
        endcase

always @*
    case (state)
        2'b00: // A
            out = 1'b0;
        2'b01: // B
            out = 1'b1;
    endcase

endmodule

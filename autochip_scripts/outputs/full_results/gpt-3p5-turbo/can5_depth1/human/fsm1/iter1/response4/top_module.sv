module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);
    
reg [1:0] state;

always @(posedge clk or posedge areset)
    if (areset)
        state <= 2'b01; // asynchronously reset to state B
    else
        case (state)
            2'b01: if (in) state <= 2'b00; else state <= 2'b01;
            2'b00: if (in) state <= 2'b01; else state <= 2'b00;
        endcase

// output assignment
always @(state, in)
    case (state)
        2'b01: out = 1'b1;
        2'b00: out = 1'b0;
    endcase

endmodule

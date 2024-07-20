module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    reg [1:0] state_next, state_current;

    parameter A = 2'b00;
    parameter B = 2'b01;

    always @(posedge clk or posedge areset)
    if (areset)
        state_current <= A;
    else
        state_current <= state_next;

    always @(state_current or x)
        case (state_current)
            A: if (x)
                    state_next = B;
                else
                    state_next = A;

            B: if (x)
                    state_next = A;
                else
                    state_next = B;
        endcase

    always @(posedge clk or posedge areset)
    if (areset)
        z <= 1'b0;
    else if (state_next == B)
        z <= 1'b0;
    else
        z <= 1'b1;

endmodule

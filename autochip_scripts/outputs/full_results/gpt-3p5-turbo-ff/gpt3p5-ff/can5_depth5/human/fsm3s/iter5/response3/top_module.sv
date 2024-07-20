module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    reg [1:0] state_reg, state_next;

    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;

    always @(posedge clk or posedge reset)
        if (reset)
            state_reg <= A;
        else
            state_reg <= state_next;

    always @(state_reg, in)
        case(state_reg)
            A: begin
                if (in)
                    state_next = B;
                else
                    state_next = A;
                out = 0;
            end
            B: begin
                if (in)
                    state_next = C;
                else
                    state_next = B;
                out = 0;
            end
            C: begin
                if (in)
                    state_next = D;
                else
                    state_next = A;
                out = 0;
            end
            D: begin
                if (in)
                    state_next = B;
                else
                    state_next = C;
                out = 1;
            end
        endcase

endmodule

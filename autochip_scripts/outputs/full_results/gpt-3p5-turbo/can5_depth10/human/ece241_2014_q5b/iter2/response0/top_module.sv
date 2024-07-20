module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    reg [1:0] state_next, state_current;
    reg reset_next, reset_current;

    parameter A = 2'b00;
    parameter B = 2'b01;

    always @(posedge clk)
    begin
        reset_current <= areset;
        if (areset)
            state_current <= A;
        else
            state_current <= state_next;
    end

    always @(posedge clk or posedge areset)
    begin
        if (areset)
            reset_next <= 1'b1;
        else
            reset_next <= 1'b0;
    end

    always @(state_current or x)
    begin
        case (state_current)
            A: begin
                if (x)
                    state_next = B;
                else
                    state_next = A;
            end

            B: begin
                if (x)
                    state_next = B;
                else
                    state_next = A;
            end
        endcase
    end

    always @(posedge clk or posedge reset_next)
    begin
        if (reset_next)
            z <= 1'b0;
        else if (state_current == B)
            z <= 1'b0;
        else
            z <= 1'b1;
    end

endmodule

module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State Definitions
    parameter A = 1'b0;
    parameter B = 1'b1;

    // State Register
    reg state;
    reg next_state;

    // State Transition Logic
    always @(*) begin
        case (state)
            A: begin
                if (x)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                next_state = B;
            end
            default: begin
                next_state = A;
            end
        endcase
    end

    // State Flip-Flop
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Output Logic
    always @(*) begin
        if ((state == A && x) || (state == B && ~x))
            z = 1'b1;
        else
            z = 1'b0;
    end

endmodule

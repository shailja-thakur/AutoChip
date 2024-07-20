module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);
    // Define states
    parameter A = 1'b0;
    parameter B = 1'b1;

    // State register
    reg state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: if (in)
                    next_state = A;
                else
                    next_state = B;
            B: if (in)
                    next_state = B;
                else
                    next_state = A;
            default: next_state = B;
        endcase
    end

    // State update on clock and reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= B;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        out = (state == B);
    end

endmodule

module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    reg state, next_state;

    // State encoding
    parameter A = 0;
    parameter B = 1;

    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                if (in)
                    next_state = A;
                else
                    next_state = B;
            end
            B: begin
                if (in)
                    next_state = B;
                else
                    next_state = A;
            end
            default: next_state = B;
        endcase
    end

    // State register with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= B;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            A: out = 0;
            B: out = 1;
            default: out = 1; // Default to state B output
        endcase
    end

endmodule

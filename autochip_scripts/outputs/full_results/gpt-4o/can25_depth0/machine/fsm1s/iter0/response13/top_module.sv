module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    // State Encoding
    parameter A = 1'b0, B = 1'b1;

    // State Register
    reg state, next_state;

    // Combinational Logic for Next State
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
            default: next_state = A;
        endcase
    end

    // State Transition Logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B;
        else
            state <= next_state;
    end

    // Output Logic
    assign out = (state == B);

endmodule

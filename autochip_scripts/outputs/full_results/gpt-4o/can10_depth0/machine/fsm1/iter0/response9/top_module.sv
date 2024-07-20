module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    reg state, next_state;

    // State encoding
    parameter A = 1'b0, B = 1'b1;

    // State transitions
    always @(*) begin
        case(state)
            A: next_state = (in) ? A : B;
            B: next_state = (in) ? B : A;
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
    assign out = (state == B);

endmodule

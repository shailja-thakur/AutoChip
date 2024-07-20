module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    reg state, next_state;

    // State encoding
    parameter A = 1'b0;
    parameter B = 1'b1;

    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = j ? B : A;
            B: next_state = k ? A : B;
            default: next_state = A;
        endcase
    end

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            out <= 1'b0;
        else
            out <= (state == B) ? 1'b1 : 1'b0;
    end

endmodule

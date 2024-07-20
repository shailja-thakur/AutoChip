module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    reg state, next_state;
    parameter A = 1'b0, B = 1'b1;

    // State transition logic
    always @(*) begin
        case (state)
            A: if (j) next_state = B;
               else next_state = A;
            B: if (k) next_state = A;
               else next_state = B;
            default: next_state = A;
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset) state <= A;
        else state <= next_state;
    end

    // Output logic
    always @(state) begin
        if (state == B) out = 1;
        else out = 0;
    end

endmodule

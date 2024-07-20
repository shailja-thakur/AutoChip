module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // Define states 
    parameter A = 1'b0;
    parameter B = 1'b1;
    reg state, next_state;

    // State-transition logic
    always @(*) begin
        case (state)
            A: if (j)
                   next_state = B;
               else
                   next_state = A;
            B: if (k)
                   next_state = A;
               else
                   next_state = B;
            default: next_state = A; // default state
        endcase
    end

    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A; // Reset state to A
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk) begin
        out <= (state == B);
    end

endmodule

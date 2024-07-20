module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    typedef enum logic [0:0] { A = 1'b0, B = 1'b1 } state_t;
    state_t current_state, next_state;

    // State transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (current_state)
            A: if (j) next_state = B;
               else next_state = A;
            B: if (k) next_state = A;
               else next_state = B;
            default: next_state = A; // Should not happen
        endcase
    end

    // Output logic
    always_comb begin
        case (current_state)
            A: out = 1'b0;
            B: out = 1'b1;
            default: out = 1'b0; // Should not happen
        endcase
    end

endmodule

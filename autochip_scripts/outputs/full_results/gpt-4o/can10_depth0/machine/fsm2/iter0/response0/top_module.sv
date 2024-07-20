module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    typedef enum logic [0:0] {A=1'b0, B=1'b1} state_t;
    state_t current_state, next_state;

    // Determine next state
    always_comb begin
        case (current_state)
            A: next_state = j ? B : A;
            B: next_state = k ? A : B;
            default: next_state = A;
        endcase
    end

    // State update
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= A;
        else
            current_state <= next_state;
    end

    // Output logic
    always_ff @(posedge clk) begin
        case (current_state)
            A: out <= 0;
            B: out <= 1;
        endcase
    end

endmodule

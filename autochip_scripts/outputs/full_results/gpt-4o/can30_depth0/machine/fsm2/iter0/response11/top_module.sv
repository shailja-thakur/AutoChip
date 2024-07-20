module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // State encoding
    typedef enum logic {
        A = 1'b0, // State A encoded as 0
        B = 1'b1  // State B encoded as 1
    } state_t;

    state_t current_state, next_state;

    // Combinational logic to determine the next state
    always @(*) begin
        case (current_state)
            A: next_state = (j) ? B : A;
            B: next_state = (k) ? A : B;
            default: next_state = A; // Default to state A
        endcase
    end

    // Sequential logic to update the current state
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= A;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        out = (current_state == B) ? 1'b1 : 1'b0;
    end

endmodule

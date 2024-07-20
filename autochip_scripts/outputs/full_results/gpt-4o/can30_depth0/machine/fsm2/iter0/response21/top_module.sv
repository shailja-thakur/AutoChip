module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // State encoding
    typedef enum reg {A, B} state_t;
    state_t current_state, next_state;

    // Combinational logic to determine next state
    always @(*) begin
        case (current_state)
            A: next_state = (j) ? B : A;
            B: next_state = (k) ? A : B;
            default: next_state = A;
        endcase
    end

    // Clocked always block to update state
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= A;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(current_state) begin
        out = (current_state == B);
    end

endmodule

module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);
    // state definition
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // Next state logic
    always @(*) begin
        case (state)
            A: next_state = in ? A : B; // From state A
            B: next_state = in ? B : A; // From state B
            default: next_state = B; // Default state
        endcase
    end

    // State register and output logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= B;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        out = (state == B);
    end

endmodule

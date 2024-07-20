module top_module (
    input clk,
    input reset,
    input w,
    output z
);
    // Declare states
    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;

    // State registers
    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= A;   // Initial state is A on reset
        else
            current_state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (current_state)
            A: next_state = (w) ? B : A;
            B: next_state = (w) ? C : D;
            C: next_state = (w) ? E : D;
            D: next_state = (w) ? F : A;
            E: next_state = (w) ? E : D;
            F: next_state = (w) ? C : D;
            default: next_state = A;
        endcase
    end

    // Output logic
    assign z = (current_state == E) || (current_state == F);

endmodule

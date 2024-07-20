module top_module (
    input clk,
    input reset,
    input w,
    output z
);

    // State encoding
    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;

    // State variable
    state_t current_state, next_state;

    // State Transition (Next State Logic)
    always @(*) begin
        case (current_state)
            A: next_state = w ? B : A;
            B: next_state = w ? C : D;
            C: next_state = w ? E : D;
            D: next_state = w ? F : A;
            E: next_state = w ? E : D;
            F: next_state = w ? C : D;
            default: next_state = A; // Default case to handle any unexpected states
        endcase
    end

    // State Flip-Flops (State Register)
    always @(posedge clk) begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
    end

    // Output Logic
    assign z = (current_state == E) || (current_state == F);

endmodule

module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // State declarations
    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = (w) ? B : A;
            B: next_state = (w) ? C : D;
            C: next_state = (w) ? E : D;
            D: next_state = (w) ? F : A;
            E: next_state = (w) ? E : D;
            F: next_state = (w) ? C : D;
            default: next_state = A;  // Default to state A for any undefined states
        endcase
    end

    // Sequential logic for state update
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;  // Reset to initial state A
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk or negedge reset) begin
        if (!reset)
            z <= 1'b0;  // Reset the output
        else
            z <= (state == E) || (state == F);  // Set z to 1 for states E and F
    end

endmodule

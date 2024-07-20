module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // Define state encoding
    typedef enum reg [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;

    // State registers
    state_t current_state, next_state;

    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= A;  // Reset to state A
        else
            current_state <= next_state;  // Transition to next state
    end

    // Combinational logic for next state
    always @(*) begin
        case (current_state)
            A: next_state = (w) ? B : A;
            B: next_state = (w) ? C : D;
            C: next_state = (w) ? E : D;
            D: next_state = (w) ? F : A;
            E: next_state = (w) ? E : D;
            F: next_state = (w) ? C : D;
            default: next_state = A;  // Default state
        endcase
    end

    // Combinational logic for output z
    always @(*) begin
        case (current_state)
            A: z = 0;
            B: z = 0;
            C: z = 0;
            D: z = 0;
            E: z = 1;
            F: z = 1;
            default: z = 0;
        endcase
    end

endmodule

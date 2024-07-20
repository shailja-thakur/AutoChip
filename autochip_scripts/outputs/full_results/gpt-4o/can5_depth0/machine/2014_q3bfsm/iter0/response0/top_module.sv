module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    // Define state encoding
    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100
    } state_t;

    // Declare current state and next state variables
    state_t current_state, next_state;

    // Sequential block for state transitions
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= A; // Reset state to A
        else
            current_state <= next_state;
    end

    // Combinational block for state transitions based on input x
    always @(*) begin
        case (current_state)
            A: next_state = x ? B : A;
            B: next_state = x ? E : B;
            C: next_state = x ? B : C;
            D: next_state = x ? C : B;
            E: next_state = x ? E : D;
            default: next_state = A; // Default state to A
        endcase
    end

    // Combinational block for output logic based on current state
    always @(*) begin
        case (current_state)
            D: z = 1;
            E: z = 1;
            default: z = 0;
        endcase
    end

endmodule

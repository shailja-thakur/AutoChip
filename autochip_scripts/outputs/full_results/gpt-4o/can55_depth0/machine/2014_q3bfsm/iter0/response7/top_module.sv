module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    // State encoding
    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100
    } state_t;

    state_t current_state, next_state;

    // Sequential logic for state transition on clock edge
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= A;  // Initialize state to A on reset
        else
            current_state <= next_state;  // Otherwise, transition to next state
    end

    // Combinational logic for next state
    always @(*) begin
        case (current_state)
            A: next_state = x ? B : A;
            B: next_state = x ? E : B;
            C: next_state = x ? B : C;
            D: next_state = x ? C : B;
            E: next_state = x ? E : D;
            default: next_state = A;
        endcase
    end

    // Output logic
    always @(*) begin
        z = (current_state == D) || (current_state == E);
    end

endmodule

module top_module (
    input clk,
    input reset,
    input w,
    output reg z
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

    state_t state, next_state;

    // State flip-flops
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;  // Synchronous reset to state A
        else
            state <= next_state;
    end

    // State transition table
    always @(*) begin
        case(state)
            A: next_state = (w == 1'b1) ? B : A;
            B: next_state = (w == 1'b1) ? C : D;
            C: next_state = (w == 1'b1) ? E : D;
            D: next_state = (w == 1'b1) ? F : A;
            E: next_state = (w == 1'b1) ? E : D;
            F: next_state = (w == 1'b1) ? C : D;
            default: next_state = A;
        endcase
    end

    // Output logic
    always @(*) begin
        case(state)
            A, B, C, D: z = 1'b0;
            E, F: z = 1'b1;
            default: z = 1'b0;
        endcase
    end
endmodule

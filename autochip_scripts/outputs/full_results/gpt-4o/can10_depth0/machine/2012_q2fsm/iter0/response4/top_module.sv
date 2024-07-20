module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);
    
    // State encoding
    typedef enum reg [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;

    // Current state and next state registers
    state_t state, next_state;

    // Output logic
    always @(state) begin
        case (state)
            E, F: z = 1;
            default: z = 0;
        endcase
    end

    // State transition logic
    always @(state or w) begin
        case (state)
            A: next_state = w ? B : A;
            B: next_state = w ? C : D;
            C: next_state = w ? E : D;
            D: next_state = w ? F : A;
            E: next_state = w ? E : D;
            F: next_state = w ? C : D;
            default: next_state = A;
        endcase
    end

    // Synchronous state update
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

endmodule

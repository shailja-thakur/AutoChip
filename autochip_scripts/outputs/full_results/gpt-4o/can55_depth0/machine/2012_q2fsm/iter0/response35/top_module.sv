module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // State Definitions
    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;
    
    // State Registers
    state_t state, next_state;

    // State Transition Logic
    always @(*) begin
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

    // State Flip-Flops with Synchronous Reset
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= A;
        else 
            state <= next_state;
    end

    // Output Logic
    always @(*) begin
        z = (state == E || state == F) ? 1'b1 : 1'b0;
    end

endmodule

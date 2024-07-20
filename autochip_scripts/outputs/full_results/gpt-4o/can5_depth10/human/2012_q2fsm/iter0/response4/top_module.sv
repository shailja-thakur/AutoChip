module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // State Encoding
    typedef enum reg [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;

    state_t current_state, next_state;

    // State Flip-Flops
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
    end

    // State Table
    always @(*) begin
        case (current_state)
            A: next_state = w ? B : A;
            B: next_state = w ? C : D;
            C: next_state = w ? E : D;
            D: next_state = w ? F : A;
            E: next_state = w ? E : D;
            F: next_state = w ? C : D;
            default: next_state = A; // Default state should be A
        endcase
    end

    // Output Logic
    always @(*) begin
        case (current_state)
            E, F: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule

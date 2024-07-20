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

    // State variables
    state_t current_state, next_state;

    // State flip-flops (sequential logic)
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= A;  // Reset to state A
        else
            current_state <= next_state;
    end

    // Next state logic (combinational logic)
    always @(*) begin
        case (current_state)
            A: next_state = w ? B : A;
            B: next_state = w ? C : D;
            C: next_state = w ? E : D;
            D: next_state = w ? F : A;
            E: next_state = w ? E : D;
            F: next_state = w ? C : D;
            default: next_state = A;  // Should never happen
        endcase
    end

    // Output logic (combinational logic)
    always @(*) begin
        case (current_state)
            A: z = 1'b0;
            B: z = 1'b0;
            C: z = 1'b0;
            D: z = 1'b0;
            E: z = 1'b1;
            F: z = 1'b1;
            default: z = 1'b0;  // Should never happen
        endcase
    end

endmodule

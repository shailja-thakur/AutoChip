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

    state_t state, next_state;

    // State transition on clock rise
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= A; // Start from state A upon reset
        else 
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: next_state = (w == 1'b0) ? B : A;
            B: next_state = (w == 1'b0) ? C : D;
            C: next_state = (w == 1'b0) ? E : D;
            D: next_state = (w == 1'b0) ? F : A;
            E: next_state = (w == 1'b0) ? E : D;
            F: next_state = (w == 1'b0) ? C : D;
            default: next_state = A; // Default state is A
        endcase
    end

    // Output logic based on state
    always @(*) begin
        case (state)
            A, B, C, D: z = 1'b0;
            E, F: z = 1'b1;
            default: z = 1'b0;
        endcase
    end
endmodule

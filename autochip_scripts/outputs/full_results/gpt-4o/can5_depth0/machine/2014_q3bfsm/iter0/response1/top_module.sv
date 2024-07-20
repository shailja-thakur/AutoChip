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

    state_t state, next_state;

    // Next state logic
    always @(*) begin
        case(state)
            A: next_state = x ? B : A;
            B: next_state = x ? E : B;
            C: next_state = x ? B : C;
            D: next_state = x ? C : B;
            E: next_state = x ? E : D;
            default: next_state = A; // Safety default state in case of unexpected values
        endcase
    end

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        z = (state == D) || (state == E);
    end

endmodule

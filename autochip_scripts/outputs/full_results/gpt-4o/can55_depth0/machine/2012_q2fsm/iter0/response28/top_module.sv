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

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            state <= A;  // initial state
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: next_state = (w ? B : A);
            B: next_state = (w ? C : D);
            C: next_state = (w ? E : D);
            D: next_state = (w ? F : A);
            E: next_state = (w ? E : D);
            F: next_state = (w ? C : D);
            default: next_state = A;  // default state
        endcase
    end

    // Output logic
    always @(*) begin
        z = (state == E || state == F) ? 1 : 0;
    end

endmodule

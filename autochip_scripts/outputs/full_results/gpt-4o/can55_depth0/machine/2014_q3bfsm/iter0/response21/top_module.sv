module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    // State definitions using 3 bits
    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101,
        G = 3'b110,
        H = 3'b111
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: next_state = (x) ? B : A;
            B: next_state = (x) ? E : B;
            C: next_state = (x) ? B : C;
            D: next_state = (x) ? C : B;
            E: next_state = (x) ? E : D;
            default: next_state = A;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            D, E: z = 1;
            default: z = 0;
        endcase
    end

endmodule

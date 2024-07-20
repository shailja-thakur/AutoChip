module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);
    // Define state codes
    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;

    // Declare state variables
    state_t state, next_state;

    // State flip-flops (sequential logic)
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // State table (combinational logic)
    always_comb begin
        case (state)
            A: next_state = w ? B : A;
            B: next_state = w ? C : D;
            C: next_state = w ? E : D;
            D: next_state = w ? F : A;
            E: next_state = w ? E : D;
            F: next_state = w ? C : D;
            default: next_state = A; // default case to handle added robustness
        endcase
    end

    // Output logic (combinational logic)
    always_comb begin
        case (state)
            A, B, C, D: z = 1'b0;
            E, F: z = 1'b1;
            default: z = 1'b0; // default case to handle added robustness
        endcase
    end

endmodule

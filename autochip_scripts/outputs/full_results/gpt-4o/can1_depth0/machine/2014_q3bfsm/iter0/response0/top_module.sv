module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    // Define states
    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100
    } state_t;

    state_t current_state, next_state;

    // State transition always block
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic always block
    always_comb begin
        case (current_state)
            A: next_state = (x) ? B : A;
            B: next_state = (x) ? E : B;
            C: next_state = (x) ? B : C;
            D: next_state = (x) ? C : B;
            E: next_state = (x) ? E : D;
            default: next_state = A; // Default case for safety
        endcase
    end

    // Output logic always block
    always_comb begin
        case (current_state)
            D: z = 1'b1;
            E: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule

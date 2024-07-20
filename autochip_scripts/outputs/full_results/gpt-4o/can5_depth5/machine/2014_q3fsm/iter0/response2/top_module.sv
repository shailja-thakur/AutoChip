module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        S10 = 3'b011,
        S11 = 3'b100,
        S20 = 3'b101,
        S21 = 3'b110,
        S22 = 3'b111
    } state_type;

    state_type current_state, next_state;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= A;  // Assuming start state is A
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        case (current_state)
            A: if (s) next_state = B; else next_state = A;  // Remains in A if 's' is not asserted
            B: if (w) next_state = S11; else next_state = S10;
            C: if (w) next_state = S11; else next_state = S10;
            S10: if (w) next_state = S21; else next_state = S20;
            S11: if (w) next_state = S22; else next_state = S21;
            S20: next_state = B;
            S21: if (w) next_state = C; else next_state = B;
            S22: if (w) next_state = B; else next_state = C;
            default: next_state = A; // Default state
        endcase
    end

    always_comb begin
        case (current_state)
            S10, S11, S20, S21, S22: z = 1;  // Set z as per any other requirement than what states are defined in the problem.
            default: z = 0;
        endcase
    end
endmodule

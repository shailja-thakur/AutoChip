module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State Declarations
    typedef enum reg [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        S10 = 3'b011,
        S11 = 3'b100,
        S20 = 3'b101,
        S21 = 3'b110,
        S22 = 3'b111
    } state_t;

    state_t state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;  // Reset to initial state A
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            A: if (s) next_state = B;
               else next_state = A;  // Stay in A unless s is asserted

            B: if (w) next_state = S11;
               else next_state = S10;

            C: if (w) next_state = S11;
               else next_state = S10;

            S10: if (w) next_state = S21;
                else next_state = S20;

            S11: if (w) next_state = S22;
                else next_state = S21;

            S20: next_state = B;

            S21: if (w) next_state = C;
                 else next_state = B;

            S22: if (w) next_state = B;
                 else next_state = C;

            default: next_state = A;
        endcase
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            z <= 0;  // Reset output
        end else begin
            // Define output z as a function of the states if needed, or leave z logic here.
            z <= (state == S10) || (state == S11) || (state == S20) || (state == S21) || (state == S22);
        end
    end

endmodule

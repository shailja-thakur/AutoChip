module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State encoding
    typedef enum reg [2:0] {
        A       = 3'b000,
        B       = 3'b001,
        C       = 3'b010,
        S10     = 3'b011,
        S11     = 3'b100,
        S20     = 3'b101,
        S21     = 3'b110,
        S22     = 3'b111
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            A:  if (s) next_state = B;
                else next_state = A; // remain in A if s is not asserted

            B:  if (w) next_state = S11;
                else next_state = S10;

            C:  if (w) next_state = S11;
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

            default: next_state = A; // default state
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        z = 0;
        case (current_state)
            // Define output logic
            // As no output specification is provided, assuming z remains 0 in all states
            default: z = 0;
        endcase
    end

endmodule

module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

// Define states
typedef enum logic [3:0] {
    A,
    B,
    C,
    S10,
    S11,
    S20,
    S21,
    S22
} state_type;

// Declare state and next_state registers
reg [3:0] state;
reg [3:0] next_state;

// Initialize state register
always_ff @(posedge clk or posedge reset) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

// Define state transitions
always_comb begin
    case (state)
        A: begin
            if (s)
                next_state = B;
            else
                next_state = state;
        end
        B, C: begin
            if (w)
                next_state = S11;
            else
                next_state = S10;
        end
        S10: begin
            if (w)
                next_state = S21;
            else
                next_state = S20;
        end
        S11: begin
            if (w)
                next_state = S22;
            else
                next_state = S21;
        end
        S20: next_state = B;
        S21: begin
            if (w)
                next_state = C;
            else
                next_state = B;
        end
        S22: begin
            if (w)
                next_state = B;
            else
                next_state = C;
        end
        default: next_state = state;
    endcase
end

// Update outputs based on current state
always_ff @(posedge clk) begin
    case (state)
        A: z <= 0;
        B: z <= 1;
        C: z <= 0;
        S10: z <= 0;
        S11: z <= 1;
        S20: z <= 1;
        S21: z <= 1;
        S22: z <= 1;
        default: z <= 0;
    endcase
end

endmodule

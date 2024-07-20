module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

// State declaration
typedef enum reg [2:0] {
    S0,    // Initial state, treats previous input as 0
    S1,    // Seen '0'
    S2,    // Seen '01'
    S3,    // Seen '011'
    S4,    // Seen '0111'
    S5,    // Seen '01111'
    S6,    // Seen '011111'
    S7,    // Seen '0111111'
    S8     // Error state
} state_t;

state_t state, next_state;

// Sequential state transition
always @(posedge clk) begin
    if (reset)
        state <= S0;
    else
        state <= next_state;
end

// Output logic
always @(posedge clk) begin
    if (reset) begin
        disc <= 0;
        flag <= 0;
        err <= 0;
    end else begin
        disc <= (state == S6);
        flag <= (state == S7);
        err <= (state == S8);
    end
end

// Combinatorial next state logic
always @(*) begin
    case (state)
        S0: next_state = (in) ? S1 : S0;
        S1: next_state = (in) ? S2 : S0;
        S2: next_state = (in) ? S3 : S0;
        S3: next_state = (in) ? S4 : S0;
        S4: next_state = (in) ? S5 : S0;
        S5: next_state = (in) ? S6 : S0;
        S6: next_state = (in) ? S7 : (reset) ? S0 : S1;
        S7: next_state = (in) ? S8 : S0;
        S8: next_state = S8;  // Once in error state, stay there
        default: next_state = S0;
    endcase
end

endmodule

module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // State declaration
    typedef enum reg [2:0] {
        S0, // Initial state, previous input = 0
        S1, // 0 => 0, 1 => 1
        S2, // 11
        S3, // 111
        S4, // 1111
        S5, // 11111
        S6, // 111111
        S7  // 1111111 (error state)
    } state_t;

    state_t state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            S0: if (in) next_state = S1; else next_state = S0;
            S1: if (in) next_state = S2; else next_state = S0;
            S2: if (in) next_state = S3; else next_state = S0;
            S3: if (in) next_state = S4; else next_state = S0;
            S4: if (in) next_state = S5; else next_state = S0;
            S5: if (in) next_state = S6; else next_state = S0;
            S6: if (in) next_state = S7; else next_state = S0;
            S7: if (in) next_state = S7; else next_state = S0; // Remain in error state if 7 or more 1s
            default: next_state = S0;
        endcase
    end

    // State register (sequential)
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            disc <= 0;
            flag <= 0;
            err <= 0;
        end else begin
            disc <= (state == S5) && !in; // 0111110 detected
            flag <= (state == S5) && in;  // 01111110 detected
            err <= (state == S7);         // 7 or more consecutive 1s detected
        end
    end
endmodule

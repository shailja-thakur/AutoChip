module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    typedef enum reg [2:0] {
        S0, // Initial state / previous input is considered 0
        S1, // 0 detected, waiting for first 1
        S2, // 01
        S3, // 011
        S4, // 0111
        S5, // 01111
        S6, // 011111
        S7, // 0111111
        S8, // 01111110 (flag)
        S9  // 01111111 (error)
    } state_type;

    state_type state, next_state;

    // State Transition Logic
    always @(*) begin
        case (state)
            S0: next_state = in ? S1 : S0;
            S1: next_state = in ? S2 : S0;
            S2: next_state = in ? S3 : S0;
            S3: next_state = in ? S4 : S0;
            S4: next_state = in ? S5 : S0;
            S5: next_state = in ? S6 : S0;
            S6: next_state = in ? S7 : S0;
            S7: next_state = in ? S9 : S8; // 6 or 7 ones check
            S8: next_state = in ? S1 : S0; // Flag state
            S9: next_state = in ? S9 : S0; // Error state
            default: next_state = S0;
        endcase
    end
    
    // State Flip-Flops/Registers
    always @(posedge clk) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    // Output Logic
    always @(posedge clk) begin
        if (reset) begin
            disc <= 1'b0;
            flag <= 1'b0;
            err <= 1'b0;
        end
        else begin
            disc <= (state == S6 && !in); // 0111110
            flag <= (state == S8);        // 01111110
            err <= (state == S9);         // 7 or more 1s
        end
    end

endmodule

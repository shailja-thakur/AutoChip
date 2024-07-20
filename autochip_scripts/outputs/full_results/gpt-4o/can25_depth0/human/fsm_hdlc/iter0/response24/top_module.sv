module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);
   
    // State encoding
    typedef enum logic [2:0] {
        S0, // Initial or after 0 input detected
        S1, // After 1 input detected
        S2, // After 11 input detected
        S3, // After 111 input detected
        S4, // After 1111 input detected
        S5, // After 11111 input detected
        S6, // After 011111 input detected
        S7, // After 111111 input detected
        S8  // Error state: 1111111 or more
    } state_t;

    state_t state, next_state;

    // State transition
    always_ff @(posedge clk) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (state)
            S0: next_state = (in) ? S1 : S0;
            S1: next_state = (in) ? S2 : S0;
            S2: next_state = (in) ? S3 : S0;
            S3: next_state = (in) ? S4 : S0;
            S4: next_state = (in) ? S5 : S0;
            S5: next_state = (in) ? S6 : S0;
            S6: next_state = (in) ? S7 : S0;
            S7: next_state = (in) ? S8 : S0;
            S8: next_state = S8; // Remain in error state
            default: next_state = S0;
        endcase
    end

    // Output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            disc <= 1'b0;
            flag <= 1'b0;
            err <= 1'b0;
        end
        else begin
            disc <= (state == S6 && in == 1'b0);
            flag <= (state == S6 && in == 1'b1);
            err <= (state == S7 && in == 1'b1) || (state == S8);
        end
    end
    
endmodule

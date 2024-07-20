module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

    // State encoding
    typedef enum logic [2:0] {
        S0,    // Initial state, treated as though previous input were 0
        S1,    // State when last bit was 1
        S2,    // State when last 2 bits were 11
        S3,    // State when last 3 bits were 111
        S4,    // State when last 4 bits were 1111
        S5,    // State when last 5 bits were 11111
        S6,    // State when last 6 bits were 111111
        S7     // State when last 7 bits were 1111111
    } state_t;

    state_t state, next_state;

    // State transition logic
    always_comb begin
        next_state = state;
        case (state)
            S0: next_state = in ? S1 : S0;
            S1: next_state = in ? S2 : S0;
            S2: next_state = in ? S3 : S0;
            S3: next_state = in ? S4 : S0;
            S4: next_state = in ? S5 : S0;
            S5: next_state = in ? S6 : S0;
            S6: next_state = in ? S7 : S0;
            S7: next_state = in ? S7 : S0;  // Remain in error state if more than 7 consecutive ones
        endcase
    end

    // Output logic
    always_comb begin
        disc = 0;
        flag = 0;
        err = 0;
        case (state)
            S5: disc = ~in;  // Discard a bit if the next bit is 0 after 5 consecutive 1s
            S6: flag = in;   // Flag if the 7th bit is 0 (indicating 01111110 sequence)
            S7: err = 1;     // Error if 7 or more consecutive 1s
        endcase
    end

    // State register
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

endmodule

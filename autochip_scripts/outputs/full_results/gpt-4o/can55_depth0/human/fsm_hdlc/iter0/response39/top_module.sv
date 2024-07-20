module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    typedef enum logic [2:0] {
        S0, // Initial state, last input is 0
        S1, // Detected 1
        S2, // Detected 11
        S3, // Detected 111
        S4, // Detected 1111
        S5, // Detected 11111
        S6, // Detected 111111
        S7  // Detected 1111111
    } state_t;

    state_t state, next_state;

    // Sequential logic for state transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

    // Combinational logic for next state and output logic
    always_comb begin
        // Default outputs
        disc = 0;
        flag = 0;
        err = 0;
        next_state = state; // Default next state same as current state

        case (state)
            S0: begin
                if (in)
                    next_state = S1;
            end
            S1: begin
                if (in)
                    next_state = S2;
                else
                    next_state = S0;
            end
            S2: begin
                if (in)
                    next_state = S3;
                else
                    next_state = S0;
            end
            S3: begin
                if (in)
                    next_state = S4;
                else
                    next_state = S0;
            end
            S4: begin
                if (in)
                    next_state = S5;
                else
                    next_state = S0;
            end
            S5: begin
                if (in)
                    next_state = S6; // Potential flag detected in next state if 0 after S5
                else
                    next_state = S0;
            end
            S6: begin
                if (in) begin
                    next_state = S7;
                    err = 1; // Error if 7th '1' detected
                end else begin
                    // Handling 0111110 or 01111110
                    disc = 1; // 6th '0' needs to be discarded
                    next_state = S0;
                end
            end
            S7: begin
                if (in) begin
                    err = 1; // Continue detecting error if more 1s come
                end else begin
                    flag = 1; // 01111110 detected
                    next_state = S0;
                end
            end
        endcase
    end

endmodule

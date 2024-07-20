module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    // State encoding
    parameter S0 = 4'b0000,  // Initial state / No consecutive 1s
              S1 = 4'b0001,  // 1 consecutive 1
              S2 = 4'b0010,  // 2 consecutive 1s
              S3 = 4'b0011,  // 3 consecutive 1s
              S4 = 4'b0100,  // 4 consecutive 1s
              S5 = 4'b0101,  // 5 consecutive 1s
              S6 = 4'b0110,  // 6 consecutive 1s
              S7 = 4'b0111,  // 7 or more consecutive 1s => Error
              S_ERR = 4'b1000;  // Error state

    // Current and next state variables
    reg [3:0] current_state, next_state;

    // Sequential logic for state transition
    always @(posedge clk) begin
        if (reset)
            current_state <= S0;  // Reset to initial state
        else
            current_state <= next_state;
    end

    // Combinational logic for next state and outputs
    always @(*) begin
        // Default outputs
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;

        case (current_state)
            S0: begin
                if (in)
                    next_state = S1;
                else
                    next_state = S0;
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
                    next_state = S6;
                else begin
                    disc = 1'b1;
                    next_state = S0;
                end
            end
            S6: begin
                if (in) begin
                    err = 1'b1;
                    next_state = S_ERR;
                end else begin
                    flag = 1'b1;
                    next_state = S0;
                end
            end
            S7: begin
                next_state = S_ERR;
            end
            S_ERR: begin
                err = 1'b1;
                if (in)
                    next_state = S_ERR;
                else
                    next_state = S0;
            end
            default: next_state = S0;
        endcase
    end
endmodule

module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    // State encoding
    typedef enum logic [2:0] {
        S0, S1, S2, S3, S4, S5, S6, S7, SERR
    } state_t;

    state_t state, next_state;

    // Sequential logic for state transition
    always @(posedge clk) begin
        if (reset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

    // Combinational logic for next state
    always @(*) begin
        case (state)
            S0:   next_state = in ? S1 : S0;
            S1:   next_state = in ? S2 : S0;
            S2:   next_state = in ? S3 : S0;
            S3:   next_state = in ? S4 : S0;
            S4:   next_state = in ? S5 : S0;
            S5:   next_state = in ? S6 : S0;
            S6:   next_state = in ? SERR : (S0);
            SERR: next_state = in ? SERR : S0;
            default: next_state = S0;
        endcase
    end

    // Combinational logic for outputs
    always @(posedge clk) begin
        if (reset) begin
            disc <= 1'b0;
            flag <= 1'b0;
            err  <= 1'b0;
        end else begin
            // Default outputs to 0 to ensure only one cycle assertion
            disc <= 1'b0;
            flag <= 1'b0;
            err  <= 1'b0;

            case (state)
                S5: begin
                    if (~in) disc <= 1'b1; // disc after 5 consecutive 1s followed by a 0
                end
                S6: begin
                    if (~in) flag <= 1'b1; // flag after 6 consecutive 1s followed by a 0
                end 
                SERR: begin
                    if (in) err <= 1'b1; // err after 7 consecutive 1s (or more)
                end
            endcase
        end
    end
endmodule

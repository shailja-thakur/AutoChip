module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

    typedef enum logic[1:0] {
        S0, // initial state
        S1, // state after first '1'
        S2  // state after '10'
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            S0: begin
                if (x == 1)
                    next_state = S1;
                else
                    next_state = S0;
            end
            S1: begin
                if (x == 0)
                    next_state = S2;
                else
                    next_state = S1;
            end
            S2: begin
                if (x == 1)
                    next_state = S1;
                else
                    next_state = S0;
            end
            default: next_state = S0;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(negedge aresetn or posedge clk) begin
        if (~aresetn)
            state <= S0;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            S0: z = 0;
            S1: z = 0;
            S2: z = (x == 1) ? 1 : 0;
            default: z = 0;
        endcase
    end

endmodule

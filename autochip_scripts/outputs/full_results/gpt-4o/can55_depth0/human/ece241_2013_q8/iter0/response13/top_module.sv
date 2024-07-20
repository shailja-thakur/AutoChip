module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

    // State encoding
    typedef enum reg [1:0] {
        S0, // Initial state
        S1, // State after recognizing '1'
        S2  // State after recognizing '10'
    } state_t;

    state_t state, next_state;

    // Sequential logic for state transitions
    always @(negedge clk or negedge aresetn) begin
        if (!aresetn)
            state <= S0;
        else
            state <= next_state;
    end

    // Combinational logic for next state and output
    always @(*) begin
        case (state)
            S0: begin
                z = 0;
                if (x)
                    next_state = S1;
                else
                    next_state = S0;
            end
            S1: begin
                z = 0;
                if (x)
                    next_state = S1;
                else
                    next_state = S2;
            end
            S2: begin
                if (x) begin
                    next_state = S1;
                    z = 1; // Sequence '101' recognized
                end else begin
                    next_state = S0;
                    z = 0;
                end
            end
            default: begin
                next_state = S0;
                z = 0;
            end
        endcase
    end

endmodule

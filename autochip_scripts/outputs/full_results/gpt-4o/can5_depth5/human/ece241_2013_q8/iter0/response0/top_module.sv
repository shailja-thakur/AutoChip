module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // State encoding
    typedef enum logic [1:0] {
        S0,  // Initial state
        S1,  // After first '1'
        S2   // After '10'
    } state_t;

    state_t curr_state, next_state;

    // State transition
    always @(posedge clk or negedge aresetn) begin
        if (~aresetn)
            curr_state <= S0;
        else
            curr_state <= next_state;
    end

    // Next state logic and output
    always @(*) begin
        next_state = curr_state;  // Default state
        z = 1'b0;                 // Default output
        case (curr_state)
            S0: begin
                if (x)
                    next_state = S1;
            end

            S1: begin
                if (~x)
                    next_state = S2;
                else
                    next_state = S1;
            end

            S2: begin
                if (x) begin
                    next_state = S1;
                    z = 1'b1;
                end
                else
                    next_state = S0;
            end

            default: begin
                next_state = S0;
            end
        endcase
    end

endmodule

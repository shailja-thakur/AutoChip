module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // state declarations
    typedef enum reg [1:0] {
        S0,  // Initial state
        S1,  // State after seeing 1
        S2   // State after seeing 10
    } state_t;

    state_t current_state, next_state;

    // state transition and output logic
    always @* begin
        z = 0;  // Default output
        next_state = current_state;  // Default state transition

        case (current_state)
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
                    z = 1;  // Sequence "101" detected
                end
                else begin
                    next_state = S0;
                end
            end
        endcase
    end

    // state register
    always @(negedge clk or negedge aresetn) begin
        if (~aresetn) 
            current_state <= S0;
        else 
            current_state <= next_state;
    end

endmodule

module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    typedef enum reg [1:0] {
        S0, // Initial state or no matching
        S1, // State after seeing '1'
        S2  // State after seeing '10'
    } state_t;

    state_t current_state, next_state;

    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    always @(*) begin
        z = 1'b0;
        case (current_state)
            S0: begin
                if (x)
                    next_state = S1;
                else
                    next_state = S0;
            end
            S1: begin
                if (x)
                    next_state = S1;
                else
                    next_state = S2;
            end
            S2: begin
                if (x) begin
                    next_state = S1;
                    z = 1'b1; // Sequence "101" detected
                end else
                    next_state = S0;
            end
            default: next_state = S0;
        endcase
    end

endmodule

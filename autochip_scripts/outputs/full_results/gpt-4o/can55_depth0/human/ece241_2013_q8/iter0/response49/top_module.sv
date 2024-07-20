module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // State encoding
    typedef enum logic [1:0] {
        S0 = 2'd0, // Initial state
        S1 = 2'd1, // State after detecting first '1'
        S2 = 2'd2  // State after detecting '10'
    } state_t;
    
    state_t state, next_state;

    // State transition logic
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
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
                if (x)
                    next_state = S1;
                else
                    next_state = S0;
            end
            default: next_state = S0;
        endcase
    end
    
    // Output logic
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            z <= 1'b0;
        end else begin
            if (state == S2 && x == 1) begin
                z <= 1'b1;
            end else begin
                z <= 1'b0;
            end
        end
    end

endmodule

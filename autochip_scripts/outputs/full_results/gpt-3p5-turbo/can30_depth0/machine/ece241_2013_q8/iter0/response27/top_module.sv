module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);
    
    // Define states using an enum
    typedef enum logic [1:0] {S, S1, S10} state_t;
    state_t state, next_state;
    
    always_ff @(posedge clk or negedge aresetn) begin
        if (~aresetn) begin
            // Asynchronous reset
            state <= S;
            z <= 0;
        end else begin
            // Sequential logic
            state <= next_state;
            case (state)
                S: begin
                    if (x == 1)
                        next_state = S1;
                    else
                        next_state = S;
                end
                S1: begin
                    if (x == 0)
                        next_state = S10;
                    else
                        next_state = S1;
                end
                S10: begin
                    if (x == 1)
                        next_state = S1;
                    else
                        next_state = S;
                end
            endcase
        end
    end

    always_comb begin
        case (state)
            S, S1: z = 0;
            S10: z = x;
        endcase
    end
    
endmodule

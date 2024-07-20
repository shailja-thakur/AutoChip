module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // Define states
    typedef enum logic [1:0] {
        S,
        S1,
        S10
    } state_t;
    
    // Define current and next state variables
    reg state_t curr_state, next_state;
    
    // Initialize current state to S
    initial begin
        curr_state = S;
    end
    
    // Sequential logic to compute next state
    always @(posedge clk or negedge aresetn) begin
        if (~aresetn) begin
            curr_state <= S;
        end else begin
            case (curr_state)
                S: begin
                    if (x) begin
                        next_state = S1;
                    end else begin
                        next_state = S;
                    end
                end
                S1: begin
                    if (x) begin
                        next_state = S1;
                    end else begin
                        next_state = S10;
                    end
                end
                S10: begin
                    if (x) begin
                        next_state = S1;
                    end else begin
                        next_state = S;
                    end
                end
                default: next_state = S;
            endcase
        end
    end
    
    // Assign next state to current state
    always @(posedge clk or negedge aresetn) begin
        if (~aresetn) begin
            curr_state <= S;
        end else begin
            curr_state <= next_state;
        end
    end
    
    // Combinational logic for output z
    always @* begin
        case (curr_state)
            S, S1: z = 0;
            S10: z = x;
            default: z = 0;
        endcase
    end

endmodule

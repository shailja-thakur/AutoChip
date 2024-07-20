module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    typedef enum logic [3:0] {S, S1, S10} state_t;
    
    reg state;
    
    always_ff @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            state <= S;  // Initial state
        end else begin
            case (state)
                S: begin
                    if (x == 1'b1)
                        state <= S1;
                    else
                        state <= S;
                end
                S1: begin
                    if (x == 1'b1)
                        state <= S1;
                    else
                        state <= S10;
                end
                S10: begin
                    if (x == 1'b1)
                        state <= S1;
                    else
                        state <= S;
                end
                default: state <= S;
            endcase
        end
    end
    
    always_comb begin
        case (state)
            S, S1: z = 1'b0;
            S10: z = x;
            default: z = 1'b0;
        endcase
    end
    
endmodule

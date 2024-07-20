module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    reg state, state_next;
    
    always @(posedge clk or negedge aresetn) begin
        if (~aresetn)
            state <= S;
        else
            state <= state_next;
    end
    
    always @(state or x) begin
        case (state)
            S: begin
                if (x == 0)
                    state_next = S;
                else
                    state_next = S1;
            end
            S1: begin
                if (x == 0)
                    state_next = S10;
                else
                    state_next = S1;
            end
            S10: begin
                if (x == 0)
                    state_next = S;
                else
                    state_next = S1;
            end
            default: state_next = S; // Default state if invalid state value received
        endcase
    end
    
    always @(state) begin
        case (state)
            S, S1: z = 0;
            S10: z = x;
            default: z = 0; // Default output if invalid state value received
        endcase
    end
    
endmodule

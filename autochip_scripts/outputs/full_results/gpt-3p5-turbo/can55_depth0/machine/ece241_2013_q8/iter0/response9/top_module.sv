module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
    reg state, next_state;
    
    // State assignments
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            state <= S; // Initial state
        else
            state <= next_state;
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            S: begin
                if (x == 0)
                    next_state = S;
                else if (x == 1)
                    next_state = S1;
            end
            S1: begin
                if (x == 0)
                    next_state = S10;
                else if (x == 1)
                    next_state = S1;
            end
            S10: begin
                if (x == 0)
                    next_state = S;
                else if (x == 1)
                    next_state = S1;
            end
        endcase
    end
    
    // Output logic
    always @(state) begin
        case (state)
            S, S1: z = 0;
            S10: z = x;
        endcase
    end
    
endmodule

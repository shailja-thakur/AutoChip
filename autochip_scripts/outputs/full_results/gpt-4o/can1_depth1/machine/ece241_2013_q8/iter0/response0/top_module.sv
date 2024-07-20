module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    typedef enum logic [1:0] {
        S = 2'b00,
        S1 = 2'b01,
        S10 = 2'b10
    } state_t;
    
    state_t state, next_state;
    
    // Sequential logic for state transition
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            state <= S;
        else
            state <= next_state;
    end
    
    // Combinational logic for next state
    always @(*) begin
        case (state)
            S: begin
                if (x)
                    next_state = S1;
                else
                    next_state = S;
            end
            S1: begin
                if (x)
                    next_state = S1;
                else
                    next_state = S10;
            end
            S10: begin
                if (x)
                    next_state = S1;
                else
                    next_state = S;
            end
            default: next_state = S; // Default case to avoid latches
        endcase
    end
    
    // Combinational logic for output z
    always @(*) begin
        case (state)
            S: z = 0;
            S1: z = 0;
            S10: z = x;
            default: z = 0; // Default case to avoid latches
        endcase
    end
    
endmodule

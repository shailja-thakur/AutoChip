module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);
    // State Declaration
    typedef enum reg [1:0] {
        S = 2'b00,
        S1 = 2'b01,
        S10 = 2'b10
    } state_t;
    
    state_t state, next_state;
    
    // Sequential logic for state transitions
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            state <= S;
        else
            state <= next_state;
    end
    
    // Combinational logic for next state and output
    always @(*) begin
        case (state)
            S: begin
                if (x == 1)
                    next_state = S1;
                else
                    next_state = S;
                z = 0;
            end
            S1: begin
                if (x == 1)
                    next_state = S1;
                else
                    next_state = S10;
                z = 0;
            end
            S10: begin
                if (x == 1)
                    next_state = S1;
                else
                    next_state = S;
                z = x;
            end
            default: begin
                next_state = S;
                z = 0;
            end
        endcase
    end
endmodule

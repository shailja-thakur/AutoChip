module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    typedef enum reg [1:0] {
        S   = 2'd0,
        S1  = 2'd1,
        S10 = 2'd2
    } state_t;
    
    reg state, next_state;

    // State transition logic
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
            default: next_state = S; // Default case for safety
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            state <= S;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            S:   z = 1'b0;
            S1:  z = 1'b0;
            S10: z = x;
            default: z = 1'b0; // Default case for safety
        endcase
    end
endmodule

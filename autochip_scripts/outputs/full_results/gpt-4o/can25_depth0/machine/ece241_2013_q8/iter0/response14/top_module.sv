module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);
    typedef enum reg [1:0] {S, S1, S10} state_t;
    state_t state, next_state;

    always @ (posedge clk or negedge aresetn) begin
        if (!aresetn)
            state <= S;
        else
            state <= next_state;
    end

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
            default: next_state = S;
        endcase
    end

    always @(*) begin
        case (state)
            S: z = 0;
            S1: z = 0;
            S10: z = x;
            default: z = 0;
        endcase
    end
    
endmodule

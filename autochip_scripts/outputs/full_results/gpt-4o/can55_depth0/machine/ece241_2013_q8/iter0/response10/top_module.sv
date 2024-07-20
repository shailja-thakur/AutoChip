module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);
    typedef enum logic [1:0] {
        S   = 2'b00,
        S1  = 2'b01,
        S10 = 2'b10
    } state_t;

    state_t state, next_state;

    always_ff @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            state <= S;
        else
            state <= next_state;
    end

    always_comb begin
        case (state)
            S: 
                if (x == 0)
                    next_state = S;
                else
                    next_state = S1;
            S1: 
                if (x == 0)
                    next_state = S10;
                else
                    next_state = S1;
            S10: 
                if (x == 0)
                    next_state = S;
                else
                    next_state = S1;
            default: 
                next_state = S;
        endcase
    end

    always_comb begin
        case (state)
            S: z = 0;
            S1: z = 0;
            S10: z = x;
            default: z = 0;
        endcase
    end
endmodule

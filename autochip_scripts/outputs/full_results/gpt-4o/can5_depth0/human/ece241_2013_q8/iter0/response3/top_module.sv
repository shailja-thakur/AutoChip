module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    typedef enum logic [1:0] {
        S0 = 2'b00,
        S1 = 2'b01,
        S2 = 2'b10
    } state_t;
    
    state_t current_state, next_state;

    always_ff @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    always_comb begin
        case (current_state)
            S0: 
                if (x)
                    next_state = S1;
                else
                    next_state = S0;
            S1: 
                if (!x)
                    next_state = S2;
                else
                    next_state = S1;
            S2: 
                if (x)
                    next_state = S1;
                else
                    next_state = S0;
            default: 
                next_state = S0;
        endcase
    end
    
    always_ff @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            z <= 1'b0;
        else
            z <= (current_state == S2) && x;
    end

endmodule

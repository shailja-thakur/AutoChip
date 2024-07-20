module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // State declaration
    typedef enum reg [1:0] {
        S = 2'b00,
        S1 = 2'b01,
        S10 = 2'b10
    } state_t;
    
    state_t state, next_state;
    
    // State transition on clock edge or async reset
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            state <= S;
        else
            state <= next_state;
    end
    
    // State transition logic
    always @(*) begin
        case (state)
            S: 
                if (x)
                    next_state = S1;
                else
                    next_state = S;
            S1: 
                if (x)
                    next_state = S1;
                else
                    next_state = S10;
            S10: 
                if (x)
                    next_state = S1;
                else
                    next_state = S;
            default: 
                next_state = S; // default state
        endcase
    end
    
    // Output logic
    always @(*) begin
        case (state)
            S: z = 1'b0;
            S1: z = 1'b0;
            S10: z = x;
            default: z = 1'b0; // default output
        endcase
    end
    
endmodule

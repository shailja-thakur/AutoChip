module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);
    
    typedef enum reg [1:0] {S0, S1, S2} state_t;
    state_t state, next_state;

    always @ (posedge clk or negedge aresetn) begin
        if (!aresetn) 
            state <= S0;
        else 
            state <= next_state;
    end

    always @ (*) begin
        case (state)
            S0: begin
                z = 0;
                if (x) 
                    next_state = S1; 
                else 
                    next_state = S0;
            end
            
            S1: begin
                z = 0;
                if (x) 
                    next_state = S1; 
                else 
                    next_state = S2;
            end
            
            S2: begin
                if (x) begin
                    z = 1;
                    next_state = S1;
                end 
                else begin
                    z = 0;
                    next_state = S0;
                end
            end
            
            default: begin
                z = 0;
                next_state = S0;
            end
        endcase
    end
    
endmodule

module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    reg [3:0] state, next_state;

    parameter A = 0, B = 1, S0 = 2, S1 = 3, S10 = 4, G1 = 5, G2 = 6, P0 = 7, P1 = 8;
    
    always @(posedge clk or negedge resetn) begin
        if (~resetn)
            state <= A;
        else
            state <= next_state;
    end
    
    always @(state or x or y) begin
        // Default assignments
        f = 0;
        g = 0;
        
        case(state)
            A: begin
                next_state = B;
            end
            
            B: begin
                next_state = S0;
                f = 1;
            end
            
            S0: begin
                if (x)
                    next_state = S1;
                else
                    next_state = S0;
            end
            
            S1: begin
                if (x)
                    next_state = S1;
                else
                    next_state = S10;
            end
            
            S10: begin
                if (x)
                    next_state = G1;
                else
                    next_state = S0;
            end
            
            G1: begin
                if (y)
                    next_state = P1;
                else
                    next_state = G2;
                g = 1;
            end
            
            G2: begin
                if (y)
                    next_state = P1;
                else
                    next_state = P0;
                g = 1;
            end
            
            P0: begin
                next_state = P0;
            end
            
            P1: begin
                next_state = P1;
            end
        endcase
    end

endmodule

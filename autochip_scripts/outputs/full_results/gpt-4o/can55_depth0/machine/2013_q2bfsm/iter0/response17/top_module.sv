module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // State encoding
    typedef enum reg [3:0] {
        A   = 4'b0000,
        B   = 4'b0001,
        S0  = 4'b0010,
        S1  = 4'b0011,
        S10 = 4'b0100,
        G1  = 4'b0101,
        G2  = 4'b0110,
        P0  = 4'b0111,
        P1  = 4'b1000
    } state_t;
    
    state_t current_state, next_state;
    
    // State transition
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            current_state <= A;
        else
            current_state <= next_state;
    end
    
    // Next state logic
    always @(*) begin
        next_state = current_state; // Default state
        case (current_state)
            A: begin
                next_state = B;
            end
            B: begin
                next_state = S0;
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
            end
            G2: begin
                if (y)
                    next_state = P1;
                else
                    next_state = P0;
            end
            P0: begin
                next_state = P0;
            end
            P1: begin
                next_state = P1;
            end
        endcase
    end
    
    // Output logic
    always @(*) begin
        f = (current_state == B);
        
        g = (current_state == G1) || 
            (current_state == G2) || 
            (current_state == P1);
    end
    
endmodule

module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output f,
    output g
);
    
    // Define states
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter S0 = 2'b10;
    parameter S1 = 2'b11;
    parameter S10 = 2'b100;
    parameter G1 = 2'b101;
    parameter G2 = 2'b110;
    parameter P0 = 2'b111;
    parameter P1 = 2'b000;
    
    // Define current state and next state variables
    reg [2:0] state;
    reg [2:0] next_state;
    
    // Assign f and g outputs based on state
    assign f = (state == B);
    assign g = (state == G1 || state == G2 || state == P1);
    
    // Assign next state based on current state and input signals
    always @(state or x or y)
    begin
        next_state = state;
        case(state)
            A: 
                if(x)
                    next_state = B;
            B: 
                next_state = S0;
            S0:
                if(x)
                    next_state = S1;
            S1: 
                if(x)
                    next_state = S1;
                else
                    next_state = S10;
            S10: 
                if(x)
                    next_state = G1;
                else
                    next_state = S0;
            G1: 
                if(y)
                    next_state = P1;
                else
                    next_state = G2;
            G2: 
                if(y)
                    next_state = P1;
                else
                    next_state = P0;
            P0: 
                next_state = P0;
            P1: 
                next_state = P1;
            default: 
                next_state = A;
        endcase
    end
    
    // Assign current state with next state on positive edge of clock
    always @(posedge clk or negedge resetn)
    begin
        if(~resetn)
            state <= A;
        else
            state <= next_state;
    end
    
endmodule

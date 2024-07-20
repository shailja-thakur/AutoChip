module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    typedef enum reg [3:0] {
        A    = 4'b0000,
        B    = 4'b0001,
        S0   = 4'b0010,
        S1   = 4'b0011,
        S10  = 4'b0100,
        G1   = 4'b0101,
        G2   = 4'b0110,
        P0   = 4'b0111,
        P1   = 4'b1000
    } state_t;
    
    state_t state, next_state;
    
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= A;
        else
            state <= next_state;
    end
    
    always @(*) begin
        next_state = state; // Default to remain in the same state
        f = 1'b0;
        g = 1'b0;
        
        case (state)
            A: begin 
                next_state = B;
            end
            B: begin
                next_state = S0;
                f = 1'b1;
            end
            S0: begin
                next_state = (x == 1'b1) ? S1 : S0;
            end
            S1: begin
                next_state = (x == 1'b1) ? S1 : S10;
            end
            S10: begin
                next_state = (x == 1'b1) ? G1 : S0;
            end
            G1: begin
                next_state = (y == 1'b1) ? P1 : G2;
                g = 1'b1;
            end
            G2: begin
                next_state = (y == 1'b1) ? P1 : P0;
                g = 1'b1;
            end
            P0: begin
                next_state = P0;
            end
            P1: begin
                next_state = P1;
                g = 1'b1;
            end
            default: begin
                next_state = A;
            end
        endcase
    end

endmodule

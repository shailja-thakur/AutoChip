module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    typedef enum logic [3:0] {
        A = 4'b0000,
        B = 4'b0001,
        S0 = 4'b0010,
        S1 = 4'b0011,
        S10 = 4'b0100,
        G1 = 4'b0101,
        G2 = 4'b0110,
        P0 = 4'b0111,
        P1 = 4'b1000
    } state_t;

    reg state_t current_state, next_state;

    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn)
            current_state <= A;
        else
            current_state <= next_state;
    end

    always_comb begin
        next_state = current_state;
        f = 0;
        g = 0;
        
        case (current_state)
            A: next_state = B;
            B: 
                begin
                    next_state = S0;
                    f = 1;
                end
            S0: next_state = x ? S1 : S0;
            S1: next_state = x ? S1 : S10;
            S10: next_state = x ? G1 : S0;
            G1: 
                begin
                    next_state = y ? P1 : G2;
                    g = 1;
                end
            G2:
                begin
                    next_state = y ? P1 : P0;
                    g = 1;
                end
            P0: next_state = P0;
            P1:
                begin
                    next_state = P1;
                    g = 1;
                end
            default: next_state = A;
        endcase
    end

endmodule

module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);
    // State encoding
    parameter A   = 4'b0000;
    parameter B   = 4'b0001;
    parameter S0  = 4'b0010;
    parameter S1  = 4'b0011;
    parameter S10 = 4'b0100;
    parameter G1  = 4'b0101;
    parameter G2  = 4'b0110;
    parameter P0  = 4'b0111;
    parameter P1  = 4'b1000;

    reg [3:0] state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A:   next_state = B;
            B:   next_state = S0;
            S0:  next_state = (x) ? S1 : S0;
            S1:  next_state = (x) ? S1 : S10;
            S10: next_state = (x) ? G1 : S0;
            G1:  next_state = (y) ? P1 : G2;
            G2:  next_state = (y) ? P1 : P0;
            P0:  next_state = P0;
            P1:  next_state = P1;
            default: next_state = A;
        endcase
    end

    // State sequential logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        f = 0;
        g = 0;
        case(state)
            B: f = 1;
            G1, G2, P1: g = 1;
        endcase
    end

endmodule

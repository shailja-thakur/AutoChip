module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output f,
    output g
);

    // Declare state encoding
    typedef enum logic [3:0] {
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

    // State transition logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= A;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            A:     next_state = B;
            B:     next_state = S0;
            S0:    next_state = x ? S1 : S0;
            S1:    next_state = x ? S1 : S10;
            S10:   next_state = x ? G1 : S0;
            G1:    next_state = y ? P1 : G2;
            G2:    next_state = y ? P1 : P0;
            P0:    next_state = P0;
            P1:    next_state = P1;
            default: next_state = A;
        endcase
    end

    // Output logic
    assign f = (state == B);
    assign g = (state == G1) || (state == G2) || (state == P1);

endmodule

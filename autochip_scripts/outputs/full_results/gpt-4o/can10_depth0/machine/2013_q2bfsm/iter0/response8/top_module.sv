module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    typedef enum reg [3:0] {
        A   = 4'd0,
        B   = 4'd1,
        S0  = 4'd2,
        S1  = 4'd3,
        S10 = 4'd4,
        G1  = 4'd5,
        G2  = 4'd6,
        P0  = 4'd7,
        P1  = 4'd8
    } state_t;
    
    reg [3:0] state, next_state;
    
    // Sequential logic (state transition)
    always @(posedge clk or negedge resetn) begin
        if (~resetn)
            state <= A;
        else
            state <= next_state;
    end
    
    // Combinational logic (next state logic)
    always @(*) begin
        next_state = state; // Default to stay in current state
        case (state)
            A: next_state = B;
            B: next_state = S0;
            S0: next_state = x ? S1 : S0;
            S1: next_state = x ? S1 : S10;
            S10: next_state = x ? G1 : S0;
            G1: next_state = y ? P1 : G2;
            G2: next_state = y ? P1 : P0;
            P0: next_state = P0;
            P1: next_state = P1;
        endcase
    end
    
    // Output logic
    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            f <= 0;
            g <= 0;
        end else begin
            f <= (state == B);
            g <= (state == G1) || (state == G2) || (state == P1);
        end
    end
endmodule

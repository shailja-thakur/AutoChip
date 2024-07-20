module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

typedef enum reg [3:0] {
    STATE_A,
    STATE_B,
    STATE_S0,
    STATE_S1,
    STATE_S10,
    STATE_G1,
    STATE_G2,
    STATE_P0,
    STATE_P1
} state_t;

state_t state, next_state;

always @(posedge clk or negedge resetn) begin
    if (!resetn)
        state <= STATE_A;
    else
        state <= next_state;
end

always @(*) begin
    next_state = state;
    f = 1'b0;
    g = 1'b0;
    
    case (state)
        STATE_A: next_state = STATE_B;
        STATE_B: begin
            next_state = STATE_S0;
            f = 1'b1;
        end
        STATE_S0: next_state = x ? STATE_S1 : STATE_S0;
        STATE_S1: next_state = x ? STATE_S1 : STATE_S10;
        STATE_S10: next_state = x ? STATE_G1 : STATE_S0;
        STATE_G1: begin
            next_state = y ? STATE_P1 : STATE_G2;
            g = 1'b1;
        end
        STATE_G2: begin
            next_state = y ? STATE_P1 : STATE_P0;
            g = 1'b1;
        end
        STATE_P1: g = 1'b1;
        STATE_P0: ; // Stay in P0
    endcase
end

endmodule

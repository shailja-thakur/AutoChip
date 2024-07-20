module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    typedef enum reg [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_S0 = 3'b010,
        STATE_S1 = 3'b011,
        STATE_S10 = 3'b100,
        STATE_G1 = 3'b101,
        STATE_G2 = 3'b110,
        STATE_P0 = 3'b111,
        STATE_P1 = 3'b001 // overlapping with B, requires unique encoding 
    } state_t;
    
    state_t state, next_state;
    
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= STATE_A;
        else
            state <= next_state;
    end
    
    always @(*) begin
        case (state)
            STATE_A: next_state = STATE_B;
            STATE_B: next_state = STATE_S0;
            STATE_S0: next_state = x ? STATE_S1 : STATE_S0;
            STATE_S1: next_state = x ? STATE_S1 : STATE_S10;
            STATE_S10: next_state = x ? STATE_G1 : STATE_S0;
            STATE_G1: next_state = y ? STATE_P1 : STATE_G2;
            STATE_G2: next_state = y ? STATE_P1 : STATE_P0;
            STATE_P0: next_state = STATE_P0;
            STATE_P1: next_state = STATE_P1;
            default: next_state = STATE_A;
        endcase
    end
    
    always @(*) begin
        f = (state == STATE_B);
        g = (state == STATE_G1) || (state == STATE_G2) || (state == STATE_P1);
    end

endmodule

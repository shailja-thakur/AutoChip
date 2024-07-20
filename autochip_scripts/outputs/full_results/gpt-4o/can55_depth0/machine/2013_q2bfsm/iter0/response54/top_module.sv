module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // State encoding
    typedef enum logic [3:0] {
        STATE_A  = 4'b0000,
        STATE_B  = 4'b0001,
        STATE_S0 = 4'b0010,
        STATE_S1 = 4'b0011,
        STATE_S10 = 4'b0100,
        STATE_G1  = 4'b0101,
        STATE_G2  = 4'b0110,
        STATE_P0  = 4'b0111,
        STATE_P1  = 4'b1000
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            STATE_A:   next_state = STATE_B;
            STATE_B:   next_state = STATE_S0;
            STATE_S0:  next_state = (x) ? STATE_S1 : STATE_S0;
            STATE_S1:  next_state = (x) ? STATE_S1 : STATE_S10;
            STATE_S10: next_state = (x) ? STATE_G1 : STATE_S0;
            STATE_G1:  next_state = (y) ? STATE_P1 : STATE_G2;
            STATE_G2:  next_state = (y) ? STATE_P1 : STATE_P0;
            STATE_P0:  next_state = STATE_P0;
            STATE_P1:  next_state = STATE_P1;
            default:   next_state = STATE_A;
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        // Default assignments
        f = 0;
        g = 0;

        case (state)
            STATE_B: f = 1;
            STATE_G1, STATE_G2, STATE_P1: g = 1;
        endcase
    end

endmodule

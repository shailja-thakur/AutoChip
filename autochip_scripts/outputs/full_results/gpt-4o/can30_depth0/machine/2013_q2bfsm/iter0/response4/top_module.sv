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
    STATE_A   = 4'd0,
    STATE_B   = 4'd1,
    STATE_S0  = 4'd2,
    STATE_S1  = 4'd3,
    STATE_S10 = 4'd4,
    STATE_G1  = 4'd5,
    STATE_G2  = 4'd6,
    STATE_P0  = 4'd7,
    STATE_P1  = 4'd8
} state_t;

state_t current_state, next_state;

// State transition
always_ff @(posedge clk or negedge resetn) begin
    if (!resetn)
        current_state <= STATE_A;
    else
        current_state <= next_state;
end

// Next state logic
always_comb begin
    case (current_state)
        STATE_A: next_state = STATE_B;
        STATE_B: next_state = STATE_S0;
        STATE_S0: next_state = (x) ? STATE_S1 : STATE_S0;
        STATE_S1: next_state = (x) ? STATE_S1 : STATE_S10;
        STATE_S10: next_state = (x) ? STATE_G1 : STATE_S0;
        STATE_G1: next_state = (y) ? STATE_P1 : STATE_G2;
        STATE_G2: next_state = (y) ? STATE_P1 : STATE_P0;
        STATE_P0: next_state = STATE_P0;
        STATE_P1: next_state = STATE_P1;
        default: next_state = STATE_A; // Default case to avoid latches
    endcase
end

// Output logic
always_ff @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        f <= 1'b0;
        g <= 1'b0;
    end else begin
        case (current_state)
            STATE_B: f <= 1'b1;
            default: f <= 1'b0;
        endcase
        
        case (current_state)
            STATE_G1, STATE_G2, STATE_P1: g <= 1'b1;
            default: g <= 1'b0;
        endcase
    end
end

endmodule

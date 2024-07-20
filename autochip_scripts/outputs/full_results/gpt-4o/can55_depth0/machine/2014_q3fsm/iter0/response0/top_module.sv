module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    typedef enum reg [2:0] {
        STATE_A = 3'd0,
        STATE_B = 3'd1,
        STATE_C = 3'd2,
        STATE_S10 = 3'd3,
        STATE_S11 = 3'd4,
        STATE_S20 = 3'd5,
        STATE_S21 = 3'd6,
        STATE_S22 = 3'd7
    } state_t;
    
    state_t state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= STATE_A;
        else
            state <= next_state;
    end

    always @(*) begin
        case (state)
            STATE_A: 
                if (s) next_state = STATE_B;
                else next_state = STATE_A;
            STATE_B: 
                if (w) next_state = STATE_S11;
                else next_state = STATE_S10;
            STATE_C: 
                if (w) next_state = STATE_S11;
                else next_state = STATE_S10;
            STATE_S10: 
                if (w) next_state = STATE_S21;
                else next_state = STATE_S20;
            STATE_S11: 
                if (w) next_state = STATE_S22;
                else next_state = STATE_S21;
            STATE_S20: 
                next_state = STATE_B;
            STATE_S21: 
                if (w) next_state = STATE_C;
                else next_state = STATE_B;
            STATE_S22: 
                if (w) next_state = STATE_B;
                else next_state = STATE_C;
            default: 
                next_state = STATE_A;
        endcase
    end

    always @(posedge clk or posedge reset) begin
        if (reset)
            z <= 0;
        else begin
            case (state)
                STATE_S10, STATE_S11, STATE_S21, STATE_S22: z <= 1;
                default: z <= 0;
            endcase
        end
    end
endmodule

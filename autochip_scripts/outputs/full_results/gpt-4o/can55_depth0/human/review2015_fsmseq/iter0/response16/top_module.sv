module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    typedef enum logic [2:0] {
        IDLE = 3'd0,
        S1 = 3'd1,
        S11 = 3'd2,
        S110 = 3'd3,
        FOUND = 3'd4
    } state_t;

    state_t state, next_state;
    
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            start_shifting <= 1'b0;
        end else begin
            state <= next_state;
            if (state == FOUND)
                start_shifting <= 1'b1;
        end
    end
    
    always_comb begin
        case (state)
            IDLE:     next_state = (data == 1'b1) ? S1 : IDLE;
            S1:       next_state = (data == 1'b1) ? S11 : IDLE;
            S11:      next_state = (data == 1'b0) ? S110 : S11;
            S110:     next_state = (data == 1'b1) ? FOUND : IDLE;
            FOUND:    next_state = FOUND;
            default:  next_state = IDLE;
        endcase
    end

endmodule

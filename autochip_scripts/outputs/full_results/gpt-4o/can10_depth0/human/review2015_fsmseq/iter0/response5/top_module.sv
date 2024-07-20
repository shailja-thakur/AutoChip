module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    typedef enum reg[2:0] {
        S_IDLE  = 3'b000,
        S_1     = 3'b001,
        S_11    = 3'b010,
        S_110   = 3'b011,
        S_1101  = 3'b100
    } state_t;
    
    state_t current_state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            current_state <= S_IDLE;
            start_shifting <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        case (current_state)
            S_IDLE:  next_state = data ? S_1 : S_IDLE;
            S_1:     next_state = data ? S_11 : S_IDLE;
            S_11:    next_state = data ? S_11 : S_110;
            S_110:   next_state = data ? S_1101 : S_IDLE;
            S_1101:  next_state = S_1101;
            default: next_state = S_IDLE;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) begin
            start_shifting <= 1'b0;
        end else if (current_state == S_1101) begin
            start_shifting <= 1'b1;
        end
    end

endmodule

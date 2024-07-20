module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    // State encoding
    typedef enum logic [2:0] {
        S_IDLE = 3'b000,
        S_1    = 3'b001,
        S_11   = 3'b010,
        S_110  = 3'b011,
        S_1101 = 3'b100
    } state_t;
    
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            S_IDLE:  next_state = data ? S_1 : S_IDLE;
            S_1:     next_state = data ? S_11 : S_IDLE;
            S_11:    next_state = data ? S_11 : S_110;
            S_110:   next_state = data ? S_1101 : S_IDLE;
            S_1101:  next_state = S_1101;
            default: next_state = S_IDLE;
        endcase
    end

    // State flip-flops
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S_IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            start_shifting <= 1'b0;
        end else if (state == S_1101) begin
            start_shifting <= 1'b1;
        end
    end
    
endmodule

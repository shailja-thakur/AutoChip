module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    typedef enum logic [2:0] {
        S_IDLE = 3'b000,
        S_1    = 3'b001,
        S_11   = 3'b010,
        S_110  = 3'b011,
        S_1101 = 3'b100
    } state_t;

    state_t state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= S_IDLE;
            start_shifting <= 0;
        end
        else begin
            state <= next_state;
            if(state == S_1101)
                start_shifting <= 1;
        end
    end

    always_comb begin
        next_state = state;
        case(state)
            S_IDLE: begin
                if (data == 1) next_state = S_1;
            end
            S_1: begin
                if (data == 1) next_state = S_11;
                else next_state = S_IDLE;
            end
            S_11: begin
                if (data == 0) next_state = S_110;
                else next_state = S_1;
            end
            S_110: begin
                if (data == 1) next_state = S_1101;
                else next_state = S_IDLE;
            end
            S_1101: begin
                next_state = S_1101; // Remain in this state indefinitely
            end
        endcase
    end
endmodule

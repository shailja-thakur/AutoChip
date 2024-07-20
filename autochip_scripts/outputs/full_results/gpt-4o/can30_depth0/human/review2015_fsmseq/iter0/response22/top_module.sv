module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    typedef enum reg [2:0] {
        IDLE = 3'b000,
        S1   = 3'b001,
        S11  = 3'b010,
        S110 = 3'b011,
        S1101= 3'b100
    } state_t;

    state_t state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            start_shifting <= 1'b0;
        end
        else begin
            state <= next_state;
            if (state == S1101) begin
                start_shifting <= 1'b1;
            end
        end
    end

    always @(*) begin
        case (state)
            IDLE: begin
                if (data) next_state = S1;
                else next_state = IDLE;
            end
            S1: begin
                if (data) next_state = S11;
                else next_state = IDLE;
            end
            S11: begin
                if (data) next_state = S11;
                else next_state = S110;
            end
            S110: begin
                if (data) next_state = S1101;
                else next_state = IDLE;
            end
            S1101: begin
                next_state = S1101; // Remain in the S1101 state once the sequence is detected
            end
            default: next_state = IDLE;
        endcase
    end
endmodule

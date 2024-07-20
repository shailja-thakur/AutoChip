module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack 
);

    typedef enum reg [2:0] {
        IDLE,
        DETECT1,
        DETECT11,
        DETECT110,
        DETECT1101,
        SHIFTING,
        WAIT_COUNT,
        TIMEOUT,
        WAIT_ACK
    } state_t;

    state_t state, next_state;
    reg [1:0] shift_count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_count <= 2'b00;
        end else begin
            state <= next_state;
            if (state == SHIFTING && shift_ena)
                shift_count <= shift_count + 1;
            else if (state != SHIFTING)
                shift_count <= 2'b00;
        end
    end

    always @(*) begin
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

        case (state)
            IDLE: begin
                if (data) next_state = DETECT1;
                else next_state = IDLE;
            end

            DETECT1: begin
                if (data) next_state = DETECT11;
                else next_state = IDLE;
            end

            DETECT11: begin
                if (~data) next_state = DETECT110;
                else next_state = IDLE;
            end

            DETECT110: begin
                if (data) next_state = DETECT1101;
                else next_state = IDLE;
            end

            DETECT1101: begin
                shift_ena = 1;
                next_state = SHIFTING;
            end

            SHIFTING: begin
                shift_ena = 1;
                if (shift_count == 2'b11)
                    next_state = WAIT_COUNT;
                else
                    next_state = SHIFTING;
            end

            WAIT_COUNT: begin
                counting = 1;
                if (done_counting) 
                    next_state = TIMEOUT;
                else
                    next_state = WAIT_COUNT;
            end

            TIMEOUT: begin
                done = 1;
                if (ack)
                    next_state = IDLE;
                else
                    next_state = TIMEOUT;
            end

            WAIT_ACK: begin
                if (ack) 
                    next_state = IDLE;
                else
                    next_state = WAIT_ACK;
            end

            default: next_state = IDLE;
        endcase
    end

endmodule

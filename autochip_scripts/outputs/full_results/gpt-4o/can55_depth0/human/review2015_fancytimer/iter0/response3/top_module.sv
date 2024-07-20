module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    typedef enum logic [2:0] {
        IDLE        = 3'd0,
        DETECT_1    = 3'd1,
        DETECT_11   = 3'd2,
        DETECT_110  = 3'd3,
        DETECT_1101 = 3'd4,
        LOAD_DELAY  = 3'd5,
        COUNTDOWN   = 3'd6,
        WAIT_ACK    = 3'd7
    } state_t;

    state_t state, next_state;
    reg [3:0] delay;
    reg [15:0] countdown;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            delay <= 4'b0;
            countdown <= 16'b0;
            count <= 4'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;

            if (state == LOAD_DELAY) begin
                delay <= {delay[2:0], data};
            end

            if (state == COUNTDOWN) begin
                if (countdown > 0) begin
                    countdown <= countdown - 1;
                    if (countdown[9:0] == 10'd0) begin
                        if (count > 0)
                            count <= count - 1;
                    end
                end
            end

            if (state == WAIT_ACK && ack) begin
                delay <= 4'b0;
                countdown <= 16'b0;
                count <= 4'b0;
                counting <= 1'b0;
                done <= 1'b0;
            end
        end
    end

    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                done = 1'b0;
                counting = 1'b0;
                if (data)
                    next_state = DETECT_1;
            end

            DETECT_1: begin
                if (data)
                    next_state = DETECT_11;
                else
                    next_state = IDLE;
            end

            DETECT_11: begin
                if (data)
                    next_state = DETECT_110;
                else
                    next_state = IDLE;
            end

            DETECT_110: begin
                if (data)
                    next_state = DETECT_1101;
                else
                    next_state = IDLE;
            end

            DETECT_1101: begin
                next_state = LOAD_DELAY;
            end

            LOAD_DELAY: begin
                if (&delay) begin // All 4 bits of delay last value is loaded
                    next_state = COUNTDOWN;
                    countdown = (delay + 1) * 1000;
                    count = delay;
                end
            end

            COUNTDOWN: begin
                counting = 1'b1;
                if (countdown == 0) begin
                    done = 1'b1;
                    next_state = WAIT_ACK;
                end
            end

            WAIT_ACK: begin
                done = 1'b1;
                if (ack) begin
                    next_state = IDLE;
                end
            end

        endcase
    end

endmodule

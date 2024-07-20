module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [2:0] state, next_state;
    reg [3:0] data_shift;
    reg [15:0] counter;

    localparam STATE_IDLE = 3'd0,
               STATE_PATTERN_DETECT = 3'd1,
               STATE_SHIFT_DELAY = 3'd2,
               STATE_COUNTDOWN = 3'd3,
               STATE_DONE = 3'd4;

    reg [3:0] delay;

    // Sequential logic for state transitions
    always @(posedge clk) begin
        if (reset) begin
            state <= STATE_IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Combinational logic for next state logic and outputs
    always @(*) begin
        case (state)
            STATE_IDLE: begin
                counting = 0;
                done = 0;
                if (data_shift == 4'b1101) begin
                    next_state = STATE_PATTERN_DETECT;
                end else begin
                    next_state = STATE_IDLE;
                end
            end
            STATE_PATTERN_DETECT: begin
                counting = 0;
                done = 0;
                next_state = STATE_SHIFT_DELAY;
            end
            STATE_SHIFT_DELAY: begin
                counting = 0;
                done = 0;
                if (data_shift[3:0] != delay) begin
                    next_state = STATE_SHIFT_DELAY;
                end else begin
                    next_state = STATE_COUNTDOWN;
                end
            end
            STATE_COUNTDOWN: begin
                counting = 1;
                done = 0;
                if (counter == 0) begin
                    next_state = STATE_DONE;
                end else begin
                    next_state = STATE_COUNTDOWN;
                end
            end
            STATE_DONE: begin
                counting = 0;
                done = 1;
                if (ack) begin
                    next_state = STATE_IDLE;
                end else begin
                    next_state = STATE_DONE;
                end
            end
            default: begin
                counting = 0;
                done = 0;
                next_state = STATE_IDLE;
            end
        endcase
    end

    // Shift register for receiving serial data
    always @(posedge clk) begin
        if (reset || state == STATE_IDLE) begin
            data_shift <= 4'b0000;
        end else if (state == STATE_PATTERN_DETECT) begin
            data_shift <= {data_shift[2:0], data};
        end
    end

    // Capture the delay value when into STATE_SHIFT_DELAY
    always @(posedge clk) begin
        if (state == STATE_SHIFT_DELAY && next_state == STATE_COUNTDOWN) begin
            delay <= data_shift[3:0];
        end
    end

    // Counter for timer delay
    always @(posedge clk) begin
        if (reset || state == STATE_IDLE) begin
            counter <= 0;
        end else if (state == STATE_COUNTDOWN) begin
            if (counter == 0) begin
                counter <= (delay + 1) * 1000 - 1;
            end else begin
                counter <= counter - 1;
            end
        end
    end

    // Output the remaining time
    always @(posedge clk) begin
        if (state == STATE_COUNTDOWN) begin
            count <= counter / 1000;
        end else begin
            count <= 4'dx;
        end
    end
endmodule

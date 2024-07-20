module top_module (
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE,
        PATTERN_DETECT,
        LOAD_DELAY,
        COUNTDOWN,
        WAIT_ACK
    } state_t;
    state_t state, next_state;

    reg [3:0] shift_reg;
    reg [3:0] delay;
    reg [13:0] counter; // 14 bits to count up to 16000 (delay = 15, 16*1000)
    reg [9:0] timer; // 10 bits to count 1000 cycles

    // State machine
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            shift_reg <= 4'b0;
            delay <= 4'b0;
            counter <= 14'b0;
            timer <= 10'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (next_state == LOAD_DELAY) begin
                delay <= shift_reg;
                counter <= shift_reg * 1000 + 1000;
                timer <= 10'b0;
            end else if (next_state == COUNTDOWN) begin
                if (timer == 10'd999) begin
                    counter <= counter - 1000;
                    timer <= 10'b0;
                end else begin
                    timer <= timer + 1;
                end
            end
        end
    end  

    // Next state logic
    always_comb begin
        next_state = state;
        counting = 1'b0;
        done = 1'b0;
        case (state)
            IDLE: begin
                shift_reg = 4'b0;
                if (data) next_state = PATTERN_DETECT;
            end
            PATTERN_DETECT: begin
                if (shift_reg == 4'b1101) next_state = LOAD_DELAY;
                else shift_reg = {shift_reg[2:0], data};
            end
            LOAD_DELAY: begin
                next_state = COUNTDOWN;
            end
            COUNTDOWN: begin
                counting = 1'b1;
                if (counter == 14'd0) next_state = WAIT_ACK;
            end
            WAIT_ACK: begin
                done = 1'b1;
                if (ack) next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    // Count output
    assign count = counting ? counter / 1000 : 4'bx;

endmodule

module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    // State encoding
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        PATTERN_DETECTED = 3'b001,
        LOAD_DELAY = 3'b010,
        COUNTDOWN = 3'b011,
        DONE = 3'b100
    } state_t;

    state_t state, next_state;

    reg [3:0] pattern;
    reg [3:0] delay;
    reg [13:0] counter;
    reg [2:0] bit_count;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            pattern <= 4'b0;
            delay <= 4'b0;
            counter <= 14'b0;
            count <= 4'b1111;
            counting <= 1'b0;
            done <= 1'b0;
            bit_count <= 3'b0;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                done = 1'b0;
                counting = 1'b0;
                if (pattern == 4'b1101) next_state = PATTERN_DETECTED;
            end
            PATTERN_DETECTED: begin
                if (bit_count == 4) next_state = LOAD_DELAY;
            end
            LOAD_DELAY: begin
                next_state = COUNTDOWN;
            end
            COUNTDOWN: begin
                if (counter == 0) next_state = DONE;
            end
            DONE: begin
                if (ack) next_state = IDLE;
            end
        endcase       
    end

    always_ff @(posedge clk) begin
        case (state)
            IDLE: begin
                if (reset) begin
                    pattern <= 4'b0;
                end else begin
                    pattern <= {pattern[2:0], data};
                end
                bit_count <= 0;
            end
            PATTERN_DETECTED: begin
                delay <= {delay[2:0], data};
                bit_count <= bit_count + 1;
            end
            LOAD_DELAY: begin
                counter <= (delay + 1) * 1000;
                count <= delay;
                counting <= 1'b1;
            end
            COUNTDOWN: begin
                if (counter > 0) begin
                    counter <= counter - 1;
                    if (counter % 1000 == 0 && count > 0) begin
                        count <= count - 1;
                    end
                end else begin
                    counting <= 1'b0;
                    done <= 1'b1;
                end
            end
            DONE: begin
                if (ack) begin
                    pattern <= 4'b0;
                    delay <= 4'b0;
                    bit_count <= 3'b0;
                end
            end
        endcase
    end
endmodule

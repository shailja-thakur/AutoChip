module top_module (
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    typedef enum logic [2:0] {
        IDLE,
        PATTERN_DETECT,
        LOAD_DELAY,
        COUNTING,
        WAIT_ACK
    } state_t;

    state_t state, next_state;
    reg [3:0] delay;
    reg [12:0] counter;
    reg [4:0] data_shift;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            delay <= 0;
            counter <= 0;
            data_shift <= 0;
            count <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        if (state == PATTERN_DETECT) begin
            data_shift <= {data_shift[3:0], data};
        end
    end

    always_ff @(posedge clk) begin
        if (state == LOAD_DELAY) begin
            delay <= data_shift[3:0];
            count <= data_shift[3:0];
        end else if (state == COUNTING) begin
            if (counter == 0) begin
                if (count == 0) begin
                    next_state <= WAIT_ACK;
                    counting <= 0;
                    done <= 1;
                end else begin
                    count <= count - 1;
                    counter <= 1000 - 1;
                end
            end else begin
                counter <= counter - 1;
            end
        end else if (state == WAIT_ACK) begin
            if (ack) begin
                done <= 0;
                count <= 4'bx;
            end
        end
    end

    always_ff @(posedge clk) begin
        if (state == LOAD_DELAY) begin
            counter <= (delay + 1) * 1000 - 1;
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (data) begin
                    next_state = PATTERN_DETECT;
                end
            end
            PATTERN_DETECT: begin
                if (data_shift[4:1] == 4'b1101) begin
                    next_state = LOAD_DELAY;
                end
            end
            LOAD_DELAY: begin
                next_state = COUNTING;
                counting = 1;
            end
            COUNTING: begin
                if (count == 0 && counter == 0) begin
                    next_state = WAIT_ACK;
                end
            end
            WAIT_ACK: begin
                if (ack) begin
                    next_state = IDLE;
                end
            end
            default: next_state = IDLE;
        endcase
    end
endmodule

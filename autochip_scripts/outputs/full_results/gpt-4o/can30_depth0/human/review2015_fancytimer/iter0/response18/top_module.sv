module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    typedef enum reg [2:0] {SEARCH, LOAD_DELAY, COUNTING, DONE} state_t;
    state_t state, next_state;

    reg [3:0] delay;
    reg [13:0] counter;
    reg [2:0] bit_count; // to track the bits of the pattern and delay

    always @(posedge clk) begin
        if (reset) begin
            state <= SEARCH;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            SEARCH: begin
                if (bit_count == 4 && data == 1'b1) begin
                    next_state = LOAD_DELAY;
                end else begin
                    next_state = SEARCH;
                end
            end
            LOAD_DELAY: begin
                if (bit_count == 7) begin // shifted 4 more bits for delay
                    next_state = COUNTING;
                end else begin
                    next_state = LOAD_DELAY;
                end
            end
            COUNTING: begin
                if (counter == 0) begin
                    next_state = DONE;
                end else begin
                    next_state = COUNTING;
                end
            end
            DONE: begin
                if (ack) begin
                    next_state = SEARCH;
                end else begin
                    next_state = DONE;
                end
            end
            default: next_state = SEARCH;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            delay <= 4'b0000;
            counter <= 14'b0;
            counting <= 1'b0;
            done <= 1'b0;
            bit_count <= 3'b0;
            count <= 4'b0000;
        end else begin
            case (state)
                SEARCH: begin
                    counting <= 1'b0;
                    done <= 1'b0;
                    if (bit_count == 0 && data == 1'b1) begin
                        bit_count <= bit_count + 1;
                    end else if (bit_count == 1 && data == 1'b1) begin
                        bit_count <= bit_count + 1;
                    end else if (bit_count == 2 && data == 1'b0) begin
                        bit_count <= bit_count + 1;
                    end else if (bit_count == 3 && data == 1'b1) begin
                        bit_count <= bit_count + 1;
                    end else if (bit_count < 4) begin
                        bit_count <= 0; // reset if pattern broken
                    end
                end
                LOAD_DELAY: begin
                    if (bit_count < 8) begin
                        delay[7-bit_count] <= data; // MSB first
                        bit_count <= bit_count + 1;
                    end

                    if (bit_count == 7) begin
                        counter <= (delay + 1) * 1000;
                        count <= delay;
                    end
                end
                COUNTING: begin
                    counting <= 1'b1;
                    if (counter > 0) begin
                        counter <= counter - 1;
                        if (counter % 1000 == 0 && count > 0) begin
                            count <= count - 1;
                        end
                    end
                end
                DONE: begin
                    counting <= 1'b0;
                    done <= 1'b1;
                    if (ack) begin
                        bit_count <= 0;
                    end
                end
            endcase
        end
    end

endmodule

module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    // State Encoding
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        DETECT_1 = 3'b001,
        DETECT_11 = 3'b010,
        DETECT_110 = 3'b011,
        DETECT_1101 = 3'b100,
        LOAD_DELAY = 3'b101,
        COUNTING = 3'b110,
        DONE = 3'b111
    } state_t;

    state_t state, next_state;
    reg [3:0] delay;
    reg [15:0] counter;
    reg [2:0] bit_count;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (data) next_state = DETECT_1;
            end
            DETECT_1: begin
                if (data) next_state = DETECT_11;
                else next_state = IDLE;
            end
            DETECT_11: begin
                if (!data) next_state = DETECT_110;
                else next_state = IDLE;
            end
            DETECT_110: begin
                if (data) next_state = DETECT_1101;
                else next_state = IDLE;
            end
            DETECT_1101: begin
                next_state = LOAD_DELAY;
            end
            LOAD_DELAY: begin
                if (bit_count == 4) next_state = COUNTING;
            end
            COUNTING: begin
                if (counter == 0) next_state = DONE;
            end
            DONE: begin
                if (ack) next_state = IDLE;
            end
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) begin
            counting <= 0;
            done <= 0;
            counter <= 0;
            bit_count <= 0;
            delay <= 0;
            count <= 4'd0;
        end else begin
            case (state)
                DETECT_1101: begin
                    counting <= 0;
                    done <= 0;
                    counter <= 0;
                    bit_count <= 0;
                    delay <= 0;
                    count <= 0;
                end
                LOAD_DELAY: begin
                    if (bit_count < 4) begin
                        delay <= {delay[2:0], data};
                        bit_count <= bit_count + 1;
                    end
                end
                COUNTING: begin
                    counting <= 1;
                    counter <= counter - 1;
                    if (counter[9:0] == 0) begin
                        count <= count - 1;
                    end
                    if (counter == 0) begin
                        counting <= 0;
                        done <= 1;
                    end
                end
                DONE: begin
                    counting <= 0;
                    if (ack) begin
                        done <= 0;
                    end
                end
            endcase
        end
    end

    always @(posedge clk) begin
        if (state == LOAD_DELAY && next_state == COUNTING) begin
            counter <= (delay + 1) * 1000;
            count <= delay;
        end
    end

endmodule

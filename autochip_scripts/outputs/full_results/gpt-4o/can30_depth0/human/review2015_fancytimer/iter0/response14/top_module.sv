module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    // State encoding
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        DETECT = 3'b001,
        LOAD_DELAY = 3'b010,
        COUNT = 3'b011,
        DONE = 3'b100
    } state_t;
    state_t state, next_state;

    // Internal registers
    reg [3:0] delay;
    reg [12:0] counter; // 13-bit counter to count up to 8191 (2^13 - 1)
    reg [2:0] bit_count;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            counting <= 0;
            done <= 0;
            count <= 4'd0;
            delay <= 4'd0;
            counter <= 13'd0;
            bit_count <= 3'd0;
        end else begin
            state <= next_state;

            // State actions
            case (state)
                IDLE: begin
                    counting <= 0;
                    done <= 0;
                    count <= 4'd0;
                    delay <= 4'd0;
                    counter <= 13'd0;
                    bit_count <= 3'd0;
                end
                DETECT: begin
                    // This state is only for pattern detection logic insertion
                end
                LOAD_DELAY: begin
                    if (bit_count < 4) begin
                        bit_count <= bit_count + 1;
                        delay <= {delay[2:0], data};
                    end
                end
                COUNT: begin
                    counting <= 1;
                    if (counter == 13'd1000) begin
                        counter <= 13'd0;
                        if (count == 0) begin
                            counting <= 0;
                            done <= 1;
                        end else begin
                            count <= count - 1;
                        end
                    end else begin
                        counter <= counter + 1;
                    end
                end
                DONE: begin
                    if (ack) begin
                        done <= 0;
                    end
                end
            endcase
        end
    end

    // Pattern detection and state transitions
    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if ({data, 3'b000} == 4'b1101) begin // Detect 1101 pattern
                    next_state = DETECT;
                end
            end
            DETECT: begin
                if (data == 1) begin // If the pattern detected
                    next_state = LOAD_DELAY;
                end else begin
                    next_state = IDLE;
                end
            end
            LOAD_DELAY: begin
                if (bit_count == 4) begin
                    count = delay;
                    next_state = COUNT;
                end
            end
            COUNT: begin
                if (done) begin
                    next_state = DONE;
                end
            end
            DONE: begin
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule

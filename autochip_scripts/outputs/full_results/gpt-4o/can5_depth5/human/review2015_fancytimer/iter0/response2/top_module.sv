module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    // State definitions
    typedef enum reg [3:0] {
        IDLE,
        PATTERN_1,
        PATTERN_11,
        PATTERN_110,
        PATTERN_1101,
        SHIFT_DELAY,
        COUNTING,
        DONE
    } state_t;

    reg [3:0] delay;
    reg [12:0] counter; // Up to 8000 - maximum count value needed
    state_t state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            delay <= 4'd0;
            counter <= 13'd0;
            count <= 4'bz; // default "don't care" value
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = state; // Default to hold state
        case (state)
            IDLE: begin
                if (data == 1) next_state = PATTERN_1;
            end
            PATTERN_1: begin
                if (data == 1) next_state = PATTERN_11;
                else next_state = IDLE;
            end
            PATTERN_11: begin
                if (data == 0) next_state = PATTERN_110;
                else next_state = IDLE;
            end
            PATTERN_110: begin
                if (data == 1) next_state = PATTERN_1101;
                else next_state = IDLE;
            end
            PATTERN_1101: begin
                next_state = SHIFT_DELAY;
            end
            SHIFT_DELAY: begin
                if (counter == 4) next_state = COUNTING;
            end
            COUNTING: begin
                if (counter == 0) next_state = DONE;
            end
            DONE: begin
                if (ack == 1) next_state = IDLE;
            end
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            delay <= 4'd0;
            counter <= 13'd0;
            count <= 4'bz;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            case (state)
                IDLE, PATTERN_1, PATTERN_11, PATTERN_110: begin
                    delay <= 4'd0;
                    counter <= 13'd0;
                    count <= 4'bz;
                    counting <= 1'b0;
                    done <= 1'b0;
                end
                PATTERN_1101: begin
                    delay <= 4'd0;
                    counter <= 0;
                end
                SHIFT_DELAY: begin
                    delay <= {delay[2:0], data};
                    counter <= counter + 1;
                    counting <= 1'b0;
                    done <= 1'b0;
                end
                COUNTING: begin
                    counting <= 1'b1;
                    if (counter < (delay + 1) * 1000) begin
                        count <= counter / 1000;
                        counter <= counter + 1;
                    end else begin
                        counting <= 1'b0;
                        done <= 1'b1;
                    end
                end
                DONE: begin
                    count <= 4'bz;
                    counting <= 1'b0;
                    done <= 1'b1;
                    if (ack == 1) done <= 1'b0;
                end
            endcase
        end
    end

endmodule

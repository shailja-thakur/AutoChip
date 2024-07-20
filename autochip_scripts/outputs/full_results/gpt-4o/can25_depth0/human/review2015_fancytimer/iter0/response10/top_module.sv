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
        S_IDLE,
        S_DETECT_1,
        S_DETECT_11,
        S_DETECT_110,
        S_DETECT_1101,
        S_LOAD_DELAY,
        S_COUNTING,
        S_DONE
    } state_t;

    state_t state, next_state;
    reg [3:0] delay;
    reg [15:0] counter;
    reg [2:0] bit_count;

    // State Transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S_IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        next_state = state;
        case (state)
            S_IDLE: begin
                if (data == 1'b1)
                    next_state = S_DETECT_1;
            end
            S_DETECT_1: begin
                if (data == 1'b1)
                    next_state = S_DETECT_11;
                else
                    next_state = S_IDLE;
            end
            S_DETECT_11: begin
                if (data == 1'b0)
                    next_state = S_DETECT_110;
                else
                    next_state = S_IDLE;
            end
            S_DETECT_110: begin
                if (data == 1'b1)
                    next_state = S_DETECT_1101;
                else
                    next_state = S_IDLE;
            end
            S_DETECT_1101: begin
                next_state = S_LOAD_DELAY;
            end
            S_LOAD_DELAY: begin
                if (bit_count == 3)
                    next_state = S_COUNTING;
            end
            S_COUNTING: begin
                if (counter == 16'b0)
                    next_state = S_DONE;
            end
            S_DONE: begin
                if (ack)
                    next_state = S_IDLE;
            end
        endcase
    end

    // Output logic and counter updates
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 4'b0;
            counting <= 1'b0;
            done <= 1'b0;
            delay <= 4'b0;
            counter <= 16'b0;
            bit_count <= 3'b0;
        end else begin
            case (state)
                S_IDLE: begin
                    count <= 4'bx;
                    counting <= 1'b0;
                    done <= 1'b0;
                end
                S_DETECT_1, S_DETECT_11, S_DETECT_110, S_DETECT_1101: begin
                    counting <= 1'b0;
                    done <= 1'b0;
                end
                S_LOAD_DELAY: begin
                    counting <= 1'b0;
                    done <= 1'b0;
                    delay <= {delay[2:0], data};  // Shift in the data bit
                    bit_count <= bit_count + 1;
                    if (bit_count == 3) begin
                        counter <= (delay + 1) * 1000 - 1;
                        count <= delay;
                    end
                end
                S_COUNTING: begin
                    if (counter > 0) begin
                        counter <= counter - 1;
                        if (counter % 1000 == 0 && counter != 0)
                            count <= count - 1;
                    end
                    counting <= 1'b1;
                    done <= 1'b0;
                end
                S_DONE: begin
                    counting <= 1'b0;
                    done <= 1'b1;
                    if (ack) begin
                        count <= 4'bx;
                    end
                end
            endcase
        end
    end

endmodule

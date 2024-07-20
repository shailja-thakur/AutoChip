module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);
    // State encoding
    typedef enum logic [2:0] {
        IDLE,
        PATTERN_DETECT,
        LOAD_DELAY,
        COUNTING,
        DONE
    } state_t;

    state_t state, next_state;
    reg [3:0] shift_reg;
    reg [3:0] delay;
    reg [15:0] counter;
    reg [3:0] remaining_time;
    
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            shift_reg <= 4'b0000;
            delay <= 4'b0000;
            counter <= 16'b0;
            remaining_time <= 4'b0000;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;

            case (state)
                IDLE: begin
                    shift_reg <= {shift_reg[2:0], data};
                    done <= 1'b0;
                end
                PATTERN_DETECT: begin
                    shift_reg <= {shift_reg[2:0], data};
                end
                LOAD_DELAY: begin
                    delay <= {shift_reg[2:0], data};
                    remaining_time <= {shift_reg[2:0], data};
                end
                COUNTING: begin
                    if (counter == 16'd1000) begin
                        counter <= 16'b0;
                        if (remaining_time == 4'b0000) begin
                            counting <= 1'b0;
                            done <= 1'b1;
                        end else begin
                            remaining_time <= remaining_time - 1;
                        end
                    end else begin
                        counter <= counter + 1;
                    end
                end
                DONE: begin
                    if (ack) begin
                        done <= 1'b0;
                    end
                end
            endcase
        end
    end

    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                if (shift_reg == 4'b1101) begin
                    next_state = PATTERN_DETECT;
                end
            end
            PATTERN_DETECT: begin
                next_state = LOAD_DELAY;
            end
            LOAD_DELAY: begin
                next_state = COUNTING;
                counting = 1'b1;
            end
            COUNTING: begin
                if (~counting) begin
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

    assign count = counting ? remaining_time : 4'bxxxx;

endmodule

module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack
);
    // Defining states
    typedef enum logic [2:0] {
        IDLE = 3'd0,
        PATTERN_1 = 3'd1,
        PATTERN_11 = 3'd2,
        PATTERN_110 = 3'd3,
        PATTERN_1101 = 3'd4,
        SHIFTING = 3'd5,
        COUNTING = 3'd6,
        DONE = 3'd7
    } state_t;

    state_t state, next_state;
    reg [1:0] shift_count;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (data == 1) begin
                    next_state = PATTERN_1;
                end else begin
                    next_state = IDLE;
                end
            end
            PATTERN_1: begin
                if (data == 1) begin
                    next_state = PATTERN_11;
                end else begin
                    next_state = IDLE;
                end
            end
            PATTERN_11: begin
                if (data == 0) begin
                    next_state = PATTERN_110;
                end else begin
                    next_state = IDLE;
                end
            end
            PATTERN_110: begin
                if (data == 1) begin
                    next_state = PATTERN_1101;
                end else begin
                    next_state = IDLE;
                end
            end
            PATTERN_1101: begin
                next_state = SHIFTING;
            end
            SHIFTING: begin
                if (shift_count == 2'b11) begin
                    next_state = COUNTING;
                end else begin
                    next_state = SHIFTING;
                end
            end
            COUNTING: begin
                if (done_counting) begin
                    next_state = DONE;
                end else begin
                    next_state = COUNTING;
                end
            end
            DONE: begin
                if (ack) begin
                    next_state = IDLE;
                end else begin
                    next_state = DONE;
                end
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic and shift counter
    always @(posedge clk) begin
        if (reset) begin
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
            shift_count <= 0;
        end else begin
            case (state)
                IDLE: begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                    shift_count <= 0;
                end
                PATTERN_1,
                PATTERN_11,
                PATTERN_110,
                PATTERN_1101: begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                end
                SHIFTING: begin
                    shift_ena <= 1;
                    if (shift_count < 2'b11) begin
                        shift_count <= shift_count + 1;
                    end else begin
                        shift_ena <= 0;
                    end
                end
                COUNTING: begin
                    shift_ena <= 0;
                    counting <= 1;
                    done <= 0;
                end
                DONE: begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 1;
                end
                default: begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                end
            endcase
        end
    end
endmodule

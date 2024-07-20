module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    typedef enum logic [2:0] {
        IDLE,
        DETECT_1,
        DETECT_11,
        DETECT_110,
        DETECT_1101,
        SHIFT,
        WAIT_COUNT,
        DONE
    } state_t;

    state_t state, next_state;
    int shift_counter;
    
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
            shift_counter <= 0;
        end else begin
            case (state)
                IDLE: begin
                    shift_ena <= 1'b0;
                    counting <= 1'b0;
                    done <= 1'b0;
                    shift_counter <= 0;
                end
                DETECT_1: ;
                DETECT_11: ;
                DETECT_110: ;
                DETECT_1101: begin
                    shift_ena <= 1'b1;
                end
                SHIFT: begin
                    shift_counter <= shift_counter + 1;
                    if (shift_counter == 4) begin
                        shift_ena <= 1'b0;
                        shift_counter <= 0;
                    end
                end
                WAIT_COUNT: begin
                    counting <= 1'b1;
                    if (done_counting) begin
                        counting <= 1'b0;
                        done <= 1'b1;
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
                if (data) next_state = DETECT_1;
            end
            DETECT_1: begin
                if (data) next_state = DETECT_11;
                else next_state = IDLE;
            end
            DETECT_11: begin
                if (~data) next_state = DETECT_110;
                else next_state = IDLE;
            end
            DETECT_110: begin
                if (data) next_state = DETECT_1101;
                else next_state = IDLE;
            end
            DETECT_1101: begin
                next_state = SHIFT;
            end
            SHIFT: begin
                if (shift_counter == 4) begin
                    next_state = WAIT_COUNT;
                end
            end
            WAIT_COUNT: begin
                if (done_counting) begin
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

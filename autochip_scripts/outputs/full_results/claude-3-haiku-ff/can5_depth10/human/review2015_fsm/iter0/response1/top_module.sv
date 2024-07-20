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

    reg [3:0] state;
    parameter [3:0] IDLE = 0, DETECT_1101 = 1, SHIFT_DURATION = 2, WAIT_COUNTING = 3, NOTIFY_USER = 4;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
        end
        else begin
            case (state)
                IDLE: begin
                    if (data == 1'b1) begin
                        state <= DETECT_1101;
                    end
                    else begin
                        state <= IDLE;
                    end
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                end
                DETECT_1101: begin
                    if (data == 1'b1) begin
                        state <= DETECT_1101;
                    end
                    else if (data == 1'b0) begin
                        state <= SHIFT_DURATION;
                        shift_ena <= 1;
                    end
                    else begin
                        state <= IDLE;
                    end
                    counting <= 0;
                    done <= 0;
                end
                SHIFT_DURATION: begin
                    if (shift_ena == 1) begin
                        shift_ena <= 1;
                    end
                    else begin
                        state <= WAIT_COUNTING;
                        shift_ena <= 0;
                        counting <= 1;
                    end
                    done <= 0;
                end
                WAIT_COUNTING: begin
                    if (done_counting == 1) begin
                        state <= NOTIFY_USER;
                        counting <= 0;
                        done <= 1;
                    end
                    else begin
                        state <= WAIT_COUNTING;
                        counting <= 1;
                        done <= 0;
                    end
                    shift_ena <= 0;
                end
                NOTIFY_USER: begin
                    if (ack == 1) begin
                        state <= IDLE;
                    end
                    else begin
                        state <= NOTIFY_USER;
                    end
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 1;
                end
                default: begin
                    state <= IDLE;
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                end
            endcase
        end
    end

endmodule

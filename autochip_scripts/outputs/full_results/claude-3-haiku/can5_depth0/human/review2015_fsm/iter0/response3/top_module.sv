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

    // State definitions
    parameter IDLE = 3'b000;
    parameter DETECT_START = 3'b001;
    parameter SHIFT_DURATION = 3'b010;
    parameter WAIT_COUNTER = 3'b011;
    parameter NOTIFY_TIMER = 3'b100;

    reg [2:0] state;
    reg [3:0] shift_count;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
            shift_count <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (data == 1'b1) begin
                        state <= DETECT_START;
                    end else begin
                        state <= IDLE;
                    end
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                end

                DETECT_START: begin
                    if (data == 1'b1) begin
                        state <= DETECT_START;
                    end else if (data == 1'b0) begin
                        state <= SHIFT_DURATION;
                        shift_count <= 0;
                    end else begin
                        state <= IDLE;
                    end
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                end

                SHIFT_DURATION: begin
                    if (shift_count < 4) begin
                        shift_ena <= 1;
                        shift_count <= shift_count + 1;
                    end else begin
                        shift_ena <= 0;
                        state <= WAIT_COUNTER;
                    end
                    counting <= 0;
                    done <= 0;
                end

                WAIT_COUNTER: begin
                    if (done_counting) begin
                        state <= NOTIFY_TIMER;
                    end else begin
                        state <= WAIT_COUNTER;
                    end
                    shift_ena <= 0;
                    counting <= 1;
                    done <= 0;
                end

                NOTIFY_TIMER: begin
                    if (ack) begin
                        state <= IDLE;
                    end else begin
                        state <= NOTIFY_TIMER;
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

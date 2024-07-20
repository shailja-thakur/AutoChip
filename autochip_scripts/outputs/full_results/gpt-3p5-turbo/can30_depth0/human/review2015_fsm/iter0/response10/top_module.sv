module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    reg [3:0] state;  // internal state variable

    // State definition
    localparam IDLE = 0;
    localparam DETECT_PATTERN = 1;
    localparam SHIFT_ENABLE = 2;
    localparam WAIT_FOR_COUNTING = 3;
    localparam TIMER_DONE = 4;
    localparam WAIT_FOR_ACK = 5;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            case (state)
                IDLE:
                    if (data == 4'b1101) begin
                        state <= DETECT_PATTERN;
                    end
                DETECT_PATTERN:
                    state <= SHIFT_ENABLE;
                SHIFT_ENABLE:
                    if (shift_ena) begin
                        state <= WAIT_FOR_COUNTING;
                    end else begin
                        state <= SHIFT_ENABLE;
                    end
                WAIT_FOR_COUNTING:
                    if (done_counting) begin
                        state <= TIMER_DONE;
                    end else begin
                        state <= WAIT_FOR_COUNTING;
                    end
                TIMER_DONE:
                    state <= WAIT_FOR_ACK;
                WAIT_FOR_ACK:
                    if (ack) begin
                        state <= IDLE;
                    end else begin
                        state <= WAIT_FOR_ACK;
                    end
            endcase
        end
    end

    // Output assignments based on state
    always @(state) begin
        case (state)
            IDLE:
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            DETECT_PATTERN:
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            SHIFT_ENABLE:
                shift_ena <= 1;
                counting <= 0;
                done <= 0;
            WAIT_FOR_COUNTING:
                shift_ena <= 0;
                counting <= 1;
                done <= 0;
            TIMER_DONE:
                shift_ena <= 0;
                counting <= 0;
                done <= 1;
            WAIT_FOR_ACK:
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
        endcase
    end

endmodule

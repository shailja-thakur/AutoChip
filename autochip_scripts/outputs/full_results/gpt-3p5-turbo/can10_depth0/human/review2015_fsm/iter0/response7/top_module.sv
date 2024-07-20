module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // Define states for the finite state machine
    parameter IDLE = 2'b00;
    parameter START_DETECT = 2'b01;
    parameter SHIFT_ENA = 2'b10;
    parameter WAIT_DONE_COUNTING = 2'b11;

    reg [1:0] state;

    always @(posedge clk, posedge reset)
    begin
        if (reset)
            state <= IDLE;
        else
        begin
            case (state)
                IDLE:
                    if (data == 4'b1101)
                        state <= START_DETECT;
                    else
                        state <= IDLE;
                START_DETECT:
                    state <= SHIFT_ENA;
                SHIFT_ENA:
                    if (shift_ena)  // Output active for 4 clock cycles
                        state <= WAIT_DONE_COUNTING;
                    else
                        state <= SHIFT_ENA;
                WAIT_DONE_COUNTING:
                    if (done_counting)
                        state <= IDLE;
                    else
                        state <= WAIT_DONE_COUNTING;
                default:
                    state <= IDLE;
            endcase
        end
    end

    always @(posedge clk)
    begin
        case (state)
            IDLE:
                begin
                    shift_ena <= 0;
                    counting <= 0;
                end
            START_DETECT:
                begin
                    shift_ena <= 1;
                    counting <= 0;
                end
            SHIFT_ENA:
                begin
                    shift_ena <= 0;
                    counting <= 1;
                end
            WAIT_DONE_COUNTING:
                begin
                    shift_ena <= 0;
                    counting <= 0;
                end
            default:
                begin
                    shift_ena <= 0;
                    counting <= 0;
                end
        endcase
    end

    always @(*)
    begin
        case (state)
            IDLE:
                done <= 0;
            START_DETECT:
                done <= 0;
            SHIFT_ENA:
                done <= 0;
            WAIT_DONE_COUNTING:
                done <= 1;
            default:
                done <= 0;
        endcase
    end

endmodule

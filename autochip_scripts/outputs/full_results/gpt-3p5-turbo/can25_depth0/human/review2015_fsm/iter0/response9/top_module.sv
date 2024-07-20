module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    reg [1:0] state;  // State variable

    // State definition
    parameter IDLE = 2'b00;
    parameter DETECT_START = 2'b01;
    parameter SHIFT_IN = 2'b10;
    parameter WAIT_COUNTING = 2'b11;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;  // Reset to initial state
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            case(state)
                IDLE: begin
                    if (data == 4'b1101) begin
                        state <= DETECT_START;
                    end else begin
                        state <= IDLE;
                    end
                end
                DETECT_START: begin
                    shift_ena <= 1;
                    state <= SHIFT_IN;
                end
                SHIFT_IN: begin
                    if (shift_ena == 4) begin
                        shift_ena <= 0;
                        counting <= 1;
                        state <= WAIT_COUNTING;
                    end else begin
                        shift_ena <= shift_ena + 1;
                        state <= SHIFT_IN;
                    end
                end
                WAIT_COUNTING: begin
                    if (done_counting) begin
                        done <= 1;
                        state <= IDLE;
                    end else begin
                        state <= WAIT_COUNTING;
                    end
                end
            endcase
        end
    end

    always @(posedge clk) begin
        // Reset outputs when not in WAIT_COUNTING state
        if (reset || state != WAIT_COUNTING) begin
            done <= 0;
        end
    end

endmodule

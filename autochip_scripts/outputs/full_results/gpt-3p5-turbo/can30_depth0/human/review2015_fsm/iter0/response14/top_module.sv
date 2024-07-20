module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // States
    parameter IDLE = 2'b00;
    parameter SEARCH_PATTERN = 2'b01;
    parameter WAIT_SHIFT_ENA = 2'b10;
    parameter WAIT_COUNTING = 2'b11;

    // Registers
    reg [1:0] state;

    // Synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            case (state)
                IDLE : begin
                    if (data == 4'b1101) begin
                        state <= WAIT_SHIFT_ENA;
                    else
                        state <= IDLE;
                    end
                end
                SEARCH_PATTERN : begin
                    if (data == 4'b1101) begin
                        state <= WAIT_SHIFT_ENA;
                    else
                        state <= IDLE;
                    end
                end
                WAIT_SHIFT_ENA : begin
                    if (shift_ena) begin
                        state <= WAIT_COUNTING;
                    end
                end
                WAIT_COUNTING : begin
                    if (done_counting) begin
                        state <= IDLE;
                        done <= 1'b1;
                    end
                end
                default : begin
                    state <= IDLE;
                end
            endcase
        end
    end

    // Sequential logic
    always @(posedge clk) begin
        if (reset) begin
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            case (state)
                IDLE : begin
                    shift_ena <= 1'b0;
                    counting <= 1'b0;
                end
                SEARCH_PATTERN : begin
                    shift_ena <= 1'b0;
                    counting <= 1'b0;
                end
                WAIT_SHIFT_ENA : begin
                    shift_ena <= 1'b1;
                    counting <= 1'b0;
                end
                WAIT_COUNTING : begin
                    shift_ena <= 1'b0;
                    counting <= 1'b1;
                end
            endcase
        end
    end

endmodule

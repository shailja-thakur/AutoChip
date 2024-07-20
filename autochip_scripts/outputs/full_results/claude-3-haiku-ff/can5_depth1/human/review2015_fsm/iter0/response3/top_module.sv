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
parameter [3:0] WAIT_START = 4'b0000,
                SHIFT_DURATION = 4'b0001,
                COUNTING = 4'b0010,
                DONE = 4'b0011;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end
    else begin
        case (state)
            WAIT_START: begin
                if (data == 1'b1 && data == 1'b1 && data == 1'b0 && data == 1'b1) begin
                    state <= SHIFT_DURATION;
                    shift_ena <= 1'b1;
                end
                else begin
                    shift_ena <= 1'b0;
                    counting <= 1'b0;
                    done <= 1'b0;
                end
            end
            SHIFT_DURATION: begin
                if (shift_ena == 1'b1) begin
                    if (shift_ena == 1'b1) begin
                        shift_ena <= 1'b0;
                        state <= COUNTING;
                        counting <= 1'b1;
                    end
                end
                else begin
                    shift_ena <= 1'b0;
                    counting <= 1'b0;
                    done <= 1'b0;
                end
            end
            COUNTING: begin
                if (done_counting == 1'b1) begin
                    state <= DONE;
                    counting <= 1'b0;
                    done <= 1'b1;
                end
            end
            DONE: begin
                if (ack == 1'b1) begin
                    state <= WAIT_START;
                    done <= 1'b0;
                end
            end
            default: begin
                state <= WAIT_START;
                shift_ena <= 1'b0;
                counting <= 1'b0;
                done <= 1'b0;
            end
        endcase
    end
end

endmodule

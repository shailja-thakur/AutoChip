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

parameter WAIT_FOR_START = 0;
parameter SHIFT_DURATION = 1;
parameter WAIT_FOR_COUNT = 2;
parameter NOTIFY_DONE = 3;

reg [1:0] state, next_state;
reg [3:0] shift_count;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_FOR_START;
        shift_count <= 0;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            WAIT_FOR_START: begin
                if (data == 1'b1) begin
                    if (shift_count == 4'b1101) begin
                        next_state <= SHIFT_DURATION;
                        shift_count <= 0;
                        shift_ena <= 1;
                    end
                    else begin
                        shift_count <= {shift_count[2:0], data};
                    end
                end
                else begin
                    shift_count <= 0;
                end
            end
            SHIFT_DURATION: begin
                if (shift_count == 4'b0100) begin
                    shift_ena <= 0;
                    next_state <= WAIT_FOR_COUNT;
                    counting <= 1;
                end
                else begin
                    shift_count <= shift_count + 1;
                end
            end
            WAIT_FOR_COUNT: begin
                if (done_counting) begin
                    counting <= 0;
                    next_state <= NOTIFY_DONE;
                    done <= 1;
                end
            end
            NOTIFY_DONE: begin
                if (ack) begin
                    next_state <= WAIT_FOR_START;
                    done <= 0;
                end
            end
        endcase
    end
end

endmodule

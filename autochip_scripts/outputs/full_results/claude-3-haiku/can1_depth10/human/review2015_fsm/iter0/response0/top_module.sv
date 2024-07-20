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

localparam WAIT_FOR_START = 0;
localparam SHIFT_DURATION = 1;
localparam WAIT_FOR_FINISH = 2;
localparam NOTIFY_COMPLETE = 3;

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
                if (data == 1'b1 && shift_count == 4'd3) begin
                    next_state <= SHIFT_DURATION;
                    shift_count <= 0;
                    shift_ena <= 1;
                end
                else begin
                    if (data == 1'b1) begin
                        shift_count <= shift_count + 1;
                    end
                    else begin
                        shift_count <= 0;
                    end
                    next_state <= WAIT_FOR_START;
                    shift_ena <= 0;
                end
            end
            SHIFT_DURATION: begin
                if (shift_count == 4'd3) begin
                    next_state <= WAIT_FOR_FINISH;
                    shift_ena <= 0;
                    counting <= 1;
                end
                else begin
                    shift_count <= shift_count + 1;
                    next_state <= SHIFT_DURATION;
                    shift_ena <= 1;
                end
            end
            WAIT_FOR_FINISH: begin
                if (done_counting) begin
                    next_state <= NOTIFY_COMPLETE;
                    counting <= 0;
                    done <= 1;
                end
                else begin
                    next_state <= WAIT_FOR_FINISH;
                end
            end
            NOTIFY_COMPLETE: begin
                if (ack) begin
                    next_state <= WAIT_FOR_START;
                    done <= 0;
                end
                else begin
                    next_state <= NOTIFY_COMPLETE;
                end
            end
            default: begin
                next_state <= WAIT_FOR_START;
            end
        endcase
    end
end

endmodule

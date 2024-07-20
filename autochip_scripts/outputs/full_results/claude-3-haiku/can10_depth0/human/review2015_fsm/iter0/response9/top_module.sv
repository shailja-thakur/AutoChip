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

localparam IDLE = 0, DETECT_START = 1, SHIFT_DURATION = 2, WAIT_DONE = 3, NOTIFY_DONE = 4;
reg [2:0] state;
reg [3:0] shift_count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
        shift_count <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    state <= DETECT_START;
                end
            end
            DETECT_START: begin
                if (data == 1'b1) begin
                    state <= DETECT_START;
                end
                else if (data == 1'b0) begin
                    state <= SHIFT_DURATION;
                    shift_ena <= 1;
                    shift_count <= 0;
                end
            end
            SHIFT_DURATION: begin
                shift_ena <= 1;
                shift_count <= shift_count + 1;
                if (shift_count == 4'd3) begin
                    shift_ena <= 0;
                    state <= WAIT_DONE;
                    counting <= 1;
                end
            end
            WAIT_DONE: begin
                if (done_counting) begin
                    counting <= 0;
                    state <= NOTIFY_DONE;
                    done <= 1;
                end
            end
            NOTIFY_DONE: begin
                if (ack) begin
                    done <= 0;
                    state <= IDLE;
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule

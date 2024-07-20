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

localparam [1:0] 
    WAIT_START = 2'd0,
    SHIFT_DURATION = 2'd1,
    WAIT_DONE = 2'd2,
    NOTIFY_USER = 2'd3;

reg [1:0] state, next_state;
reg [3:0] shift_count;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
        shift_count <= 4'b0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    shift_ena = 1'b0;
    counting = 1'b0;
    done = 1'b0;

    case (state)
        WAIT_START: begin
            if (data == 1'b1 && data == 1'b1 && data == 1'b0 && data == 1'b1) begin
                next_state = SHIFT_DURATION;
                shift_ena = 1'b1;
                shift_count = 4'b0;
            end
        end
        SHIFT_DURATION: begin
            shift_ena = 1'b1;
            shift_count = shift_count + 1'b1;
            if (shift_count == 4'b0100) begin
                next_state = WAIT_DONE;
            end
        end
        WAIT_DONE: begin
            counting = 1'b1;
            if (done_counting) begin
                next_state = NOTIFY_USER;
                done = 1'b1;
            end
        end
        NOTIFY_USER: begin
            if (ack) begin
                next_state = WAIT_START;
            end
        end
    endcase
end

endmodule

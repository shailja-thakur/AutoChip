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

localparam [3:0] WAIT_FOR_START = 4'b0000,
                 SHIFT_DURATION = 4'b0001,
                 WAIT_FOR_COUNT = 4'b0010,
                 NOTIFY_USER    = 4'b0011;

reg [3:0] state, next_state;
reg [3:0] shift_count;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_FOR_START;
        shift_count <= 4'b0;
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    case (state)
        WAIT_FOR_START: begin
            shift_ena = 1'b0;
            counting = 1'b0;
            done = 1'b0;
            if (data == 1'b1 && data == 1'b1 && data == 1'b0 && data == 1'b1) begin
                next_state = SHIFT_DURATION;
                shift_count = 4'b0;
            end
        end
        SHIFT_DURATION: begin
            shift_ena = 1'b1;
            counting = 1'b0;
            done = 1'b0;
            if (shift_count == 4'b0100) begin
                next_state = WAIT_FOR_COUNT;
                shift_count = 4'b0;
            end
            else begin
                shift_count = shift_count + 1'b1;
            end
        end
        WAIT_FOR_COUNT: begin
            shift_ena = 1'b0;
            counting = 1'b1;
            done = 1'b0;
            if (done_counting) begin
                next_state = NOTIFY_USER;
            end
        end
        NOTIFY_USER: begin
            shift_ena = 1'b0;
            counting = 1'b0;
            done = 1'b1;
            if (ack) begin
                next_state = WAIT_FOR_START;
            end
        end
    endcase
end

endmodule

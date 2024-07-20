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

localparam [3:0] IDLE = 4'b0000,
                 START_DETECT = 4'b0001,
                 SHIFT_DURATION = 4'b0010,
                 COUNT = 4'b0011,
                 NOTIFY = 4'b0100;

reg [3:0] state, next_state;
reg [3:0] shift_count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        shift_count <= 0;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
            START_DETECT: begin
                if (data == 1'b1) begin
                    shift_count <= shift_count + 1;
                end
                else begin
                    shift_count <= 0;
                end
                if (shift_count == 4) begin
                    next_state <= SHIFT_DURATION;
                end
            end
            SHIFT_DURATION: begin
                shift_ena <= 1;
                if (shift_count == 4) begin
                    shift_ena <= 0;
                    next_state <= COUNT;
                end
                shift_count <= shift_count + 1;
            end
            COUNT: begin
                counting <= 1;
                if (done_counting) begin
                    counting <= 0;
                    next_state <= NOTIFY;
                end
            end
            NOTIFY: begin
                done <= 1;
                if (ack) begin
                    next_state <= IDLE;
                end
            end
        endcase
    end
end

always @* begin
    case (state)
        IDLE: next_state = START_DETECT;
        START_DETECT: next_state = IDLE;
        SHIFT_DURATION: next_state = SHIFT_DURATION;
        COUNT: next_state = COUNT;
        NOTIFY: next_state = NOTIFY;
    endcase
end

endmodule

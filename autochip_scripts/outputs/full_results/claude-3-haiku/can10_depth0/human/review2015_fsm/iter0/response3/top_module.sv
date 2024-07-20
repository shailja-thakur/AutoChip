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
                 DETECT_START = 4'b0001,
                 SHIFT_DURATION = 4'b0010,
                 WAIT_COUNTING = 4'b0011,
                 NOTIFY_USER = 4'b0100,
                 WAIT_ACK = 4'b0101;

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
                if (data == 1'b1) begin
                    next_state <= DETECT_START;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            DETECT_START: begin
                if (data == 1'b1) begin
                    next_state <= DETECT_START;
                end
                else if (data == 1'b0) begin
                    next_state <= DETECT_START;
                end
                else if ({data, 3'b101} == 4'b1101) begin
                    next_state <= SHIFT_DURATION;
                    shift_count <= 0;
                    shift_ena <= 1;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            SHIFT_DURATION: begin
                if (shift_count == 4) begin
                    shift_ena <= 0;
                    next_state <= WAIT_COUNTING;
                    counting <= 1;
                end
                else begin
                    shift_count <= shift_count + 1;
                    next_state <= SHIFT_DURATION;
                end
            end
            WAIT_COUNTING: begin
                if (done_counting) begin
                    counting <= 0;
                    next_state <= NOTIFY_USER;
                    done <= 1;
                end
                else begin
                    next_state <= WAIT_COUNTING;
                end
            end
            NOTIFY_USER: begin
                if (ack) begin
                    next_state <= IDLE;
                    done <= 0;
                end
                else begin
                    next_state <= NOTIFY_USER;
                end
            end
            default: begin
                next_state <= IDLE;
            end
        endcase
    end
end

endmodule

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

parameter IDLE = 3'b000;
parameter DETECT_1101 = 3'b001;
parameter SHIFT_DURATION = 3'b010;
parameter WAIT_COUNTING = 3'b011;
parameter NOTIFY_USER = 3'b100;

reg [2:0] state, next_state;
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
                    next_state <= DETECT_1101;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            DETECT_1101: begin
                if (data == 1'b1) begin
                    next_state <= DETECT_1101;
                end
                else if (shift_count == 4'd3) begin
                    next_state <= SHIFT_DURATION;
                    shift_count <= 0;
                end
                else begin
                    next_state <= DETECT_1101;
                    shift_count <= shift_count + 1;
                end
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
            SHIFT_DURATION: begin
                if (shift_count == 4'd3) begin
                    next_state <= WAIT_COUNTING;
                    shift_ena <= 0;
                end
                else begin
                    next_state <= SHIFT_DURATION;
                    shift_ena <= 1;
                    shift_count <= shift_count + 1;
                end
                counting <= 0;
                done <= 0;
            end
            WAIT_COUNTING: begin
                shift_ena <= 0;
                if (done_counting) begin
                    next_state <= NOTIFY_USER;
                    counting <= 0;
                end
                else begin
                    next_state <= WAIT_COUNTING;
                    counting <= 1;
                end
                done <= 0;
            end
            NOTIFY_USER: begin
                shift_ena <= 0;
                counting <= 0;
                if (ack) begin
                    next_state <= IDLE;
                    done <= 0;
                end
                else begin
                    next_state <= NOTIFY_USER;
                    done <= 1;
                end
            end
            default: begin
                next_state <= IDLE;
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
        endcase
    end
end

endmodule

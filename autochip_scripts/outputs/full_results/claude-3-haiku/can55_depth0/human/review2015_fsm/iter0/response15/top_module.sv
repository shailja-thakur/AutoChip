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

parameter [2:0] IDLE = 3'b000,
                DETECT_START = 3'b001,
                SHIFT_DURATION = 3'b010,
                WAIT_COUNTER = 3'b011,
                NOTIFY_USER = 3'b100;

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
                shift_count <= 0;
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
            DETECT_START: begin
                if (data == 1'b1) begin
                    shift_ena <= 1;
                    shift_count <= shift_count + 1;
                end
                else if (shift_count == 4'd4) begin
                    shift_ena <= 0;
                    shift_count <= 0;
                    next_state <= SHIFT_DURATION;
                end
            end
            SHIFT_DURATION: begin
                if (data == 1'b1) begin
                    shift_ena <= 1;
                    shift_count <= shift_count + 1;
                end
                else if (shift_count == 4'd4) begin
                    shift_ena <= 0;
                    shift_count <= 0;
                    counting <= 1;
                    next_state <= WAIT_COUNTER;
                end
            end
            WAIT_COUNTER: begin
                if (done_counting) begin
                    counting <= 0;
                    done <= 1;
                    next_state <= NOTIFY_USER;
                end
            end
            NOTIFY_USER: begin
                if (ack) begin
                    done <= 0;
                    next_state <= IDLE;
                end
            end
        endcase
    end
end

always @* begin
    case (state)
        IDLE: next_state = DETECT_START;
        DETECT_START: begin
            if (data == 1'b1 && shift_count == 4'd3)
                next_state = DETECT_START;
            else
                next_state = IDLE;
        end
        SHIFT_DURATION: next_state = WAIT_COUNTER;
        WAIT_COUNTER: next_state = NOTIFY_USER;
        NOTIFY_USER: next_state = IDLE;
        default: next_state = IDLE;
    endcase
end

endmodule

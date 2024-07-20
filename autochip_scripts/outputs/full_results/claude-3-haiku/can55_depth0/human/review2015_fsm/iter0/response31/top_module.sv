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

localparam [3:0] IDLE = 4'd0,
                 DETECT_START = 4'd1,
                 SHIFT_DURATION = 4'd2,
                 COUNTING = 4'd3,
                 DONE = 4'd4;

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
            DETECT_START: begin
                if (data == 1'b1) begin
                    shift_count <= 0;
                    shift_ena <= 1;
                end
                else if (shift_count == 4'd3) begin
                    shift_ena <= 0;
                    next_state <= SHIFT_DURATION;
                end
                else begin
                    shift_count <= shift_count + 1;
                end
            end
            SHIFT_DURATION: begin
                if (shift_count == 4'd3) begin
                    counting <= 1;
                    next_state <= COUNTING;
                end
                else begin
                    shift_count <= shift_count + 1;
                    shift_ena <= 1;
                end
            end
            COUNTING: begin
                if (done_counting) begin
                    counting <= 0;
                    done <= 1;
                    next_state <= DONE;
                end
            end
            DONE: begin
                if (ack) begin
                    next_state <= IDLE;
                end
            end
        endcase
    end
end

always @(*) begin
    case (state)
        IDLE: next_state = DETECT_START;
        DETECT_START: begin
            if (data == 1'b1) begin
                next_state = DETECT_START;
            end
            else if (shift_count == 4'd3) begin
                next_state = SHIFT_DURATION;
            end
            else begin
                next_state = DETECT_START;
            end
        end
        SHIFT_DURATION: next_state = COUNTING;
        COUNTING: next_state = DONE;
        DONE: next_state = (ack) ? IDLE : DONE;
        default: next_state = IDLE;
    endcase
end

endmodule

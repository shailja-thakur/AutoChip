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

localparam [3:0] STATE_WAIT = 4'd0,
                 STATE_PATTERN = 4'd1,
                 STATE_SHIFT = 4'd2,
                 STATE_COUNT = 4'd3,
                 STATE_NOTIFY = 4'd4;

reg [3:0] state, next_state;
reg [3:0] shift_count;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_WAIT;
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
    case (state)
        STATE_WAIT: begin
            if (data == 1'b1) next_state = STATE_PATTERN;
        end
        STATE_PATTERN: begin
            if (data == 1'b1 || data == 1'b0) next_state = STATE_PATTERN;
            else if (data == 1'b1) next_state = STATE_SHIFT;
        end
        STATE_SHIFT: begin
            if (shift_count == 4'd4) begin
                next_state = STATE_COUNT;
                shift_count = 4'b0;
            end
            else begin
                shift_count = shift_count + 1;
            end
        end
        STATE_COUNT: begin
            if (done_counting) begin
                next_state = STATE_NOTIFY;
            end
        end
        STATE_NOTIFY: begin
            if (ack) begin
                next_state = STATE_WAIT;
            end
        end
    endcase
end

always @(*) begin
    shift_ena = 1'b0;
    counting = 1'b0;
    done = 1'b0;
    case (state)
        STATE_WAIT: begin
        end
        STATE_PATTERN: begin
        end
        STATE_SHIFT: begin
            shift_ena = 1'b1;
        end
        STATE_COUNT: begin
            counting = 1'b1;
        end
        STATE_NOTIFY: begin
            done = 1'b1;
        end
    endcase
end

endmodule

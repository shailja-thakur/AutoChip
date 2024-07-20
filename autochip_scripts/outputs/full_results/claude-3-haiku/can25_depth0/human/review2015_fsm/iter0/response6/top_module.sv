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

localparam [2:0] IDLE = 3'b000,
                 DETECT_START = 3'b001,
                 SHIFT_DURATION = 3'b010,
                 COUNTING = 3'b011,
                 DONE = 3'b100;

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
            end
            DETECT_START: begin
                if (shift_count == 4'd4) begin
                    shift_count <= 0;
                    next_state <= SHIFT_DURATION;
                end
                else begin
                    shift_count <= shift_count + 1;
                end
            end
            SHIFT_DURATION: begin
                shift_ena <= 1;
                if (shift_count == 4'd3) begin
                    shift_ena <= 0;
                    shift_count <= 0;
                    next_state <= COUNTING;
                end
                else begin
                    shift_count <= shift_count + 1;
                end
            end
            COUNTING: begin
                counting <= 1;
                if (done_counting) begin
                    counting <= 0;
                    next_state <= DONE;
                end
            end
            DONE: begin
                done <= 1;
                if (ack) begin
                    done <= 0;
                    next_state <= IDLE;
                end
            end
        endcase
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (data == 1'b1) begin
                next_state = DETECT_START;
            end
            else begin
                next_state = IDLE;
            end
        end
        DETECT_START: begin
            if (data == 1'b1 && shift_count == 4'd0) begin
                next_state = DETECT_START;
            end
            else if (data == 1'b1 && shift_count == 4'd1) begin
                next_state = DETECT_START;
            end
            else if (data == 1'b0 && shift_count == 4'd2) begin
                next_state = DETECT_START;
            end
            else if (data == 1'b1 && shift_count == 4'd3) begin
                next_state = DETECT_START;
            end
            else begin
                next_state = IDLE;
            end
        end
        SHIFT_DURATION: begin
            next_state = COUNTING;
        end
        COUNTING: begin
            if (done_counting) begin
                next_state = DONE;
            end
            else begin
                next_state = COUNTING;
            end
        end
        DONE: begin
            if (ack) begin
                next_state = IDLE;
            end
            else begin
                next_state = DONE;
            end
        end
    endcase
end

endmodule

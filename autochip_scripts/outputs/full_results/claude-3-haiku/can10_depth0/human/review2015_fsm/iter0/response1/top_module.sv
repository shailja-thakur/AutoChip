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

localparam [3:0] IDLE = 4'd0, DETECT_1101 = 4'd1, SHIFT_DURATION = 4'd2, COUNTING = 4'd3, NOTIFY_USER = 4'd4, WAIT_ACK = 4'd5;

reg [3:0] state, next_state;
reg [3:0] bit_count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                bit_count <= 0;
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
            DETECT_1101: begin
                if (bit_count == 4'd4) begin
                    bit_count <= 0;
                    next_state <= SHIFT_DURATION;
                end
                else begin
                    bit_count <= bit_count + 1;
                end
            end
            SHIFT_DURATION: begin
                shift_ena <= 1;
                if (bit_count == 4'd3) begin
                    shift_ena <= 0;
                    bit_count <= 0;
                    next_state <= COUNTING;
                end
                else begin
                    bit_count <= bit_count + 1;
                end
            end
            COUNTING: begin
                counting <= 1;
                if (done_counting) begin
                    counting <= 0;
                    next_state <= NOTIFY_USER;
                end
            end
            NOTIFY_USER: begin
                done <= 1;
                next_state <= WAIT_ACK;
            end
            WAIT_ACK: begin
                if (ack) begin
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
                next_state = DETECT_1101;
            end
            else begin
                next_state = IDLE;
            end
        end
        DETECT_1101: begin
            if (data == 1'b1 && bit_count == 4'd0) begin
                next_state = DETECT_1101;
            end
            else if (data == 1'b0 && bit_count == 4'd1) begin
                next_state = DETECT_1101;
            end
            else if (data == 1'b1 && bit_count == 4'd2) begin
                next_state = DETECT_1101;
            end
            else if (data == 1'b0 && bit_count == 4'd3) begin
                next_state = DETECT_1101;
            end
            else if (data == 1'b1 && bit_count == 4'd4) begin
                next_state = SHIFT_DURATION;
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
                next_state = NOTIFY_USER;
            end
            else begin
                next_state = COUNTING;
            end
        end
        NOTIFY_USER: begin
            next_state = WAIT_ACK;
        end
        WAIT_ACK: begin
            if (ack) begin
                next_state = IDLE;
            end
            else begin
                next_state = WAIT_ACK;
            end
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule

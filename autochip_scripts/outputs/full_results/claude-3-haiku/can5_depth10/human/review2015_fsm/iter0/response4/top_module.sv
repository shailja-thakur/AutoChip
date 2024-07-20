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
    IDLE = 2'b00,
    DETECT_SEQUENCE = 2'b01,
    SHIFT_COUNT = 2'b10,
    WAIT_FOR_TIMER = 2'b11;

reg [1:0] state, next_state;
reg [3:0] sequence_count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        sequence_count <= 0;
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
                    sequence_count <= 1;
                    next_state <= DETECT_SEQUENCE;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            DETECT_SEQUENCE: begin
                if (data == 1'b1 && sequence_count == 1) begin
                    sequence_count <= 2;
                    next_state <= DETECT_SEQUENCE;
                end
                else if (data == 1'b0 && sequence_count == 2) begin
                    sequence_count <= 3;
                    next_state <= DETECT_SEQUENCE;
                end
                else if (data == 1'b1 && sequence_count == 3) begin
                    sequence_count <= 4;
                    next_state <= SHIFT_COUNT;
                end
                else begin
                    sequence_count <= 0;
                    next_state <= IDLE;
                end
            end
            SHIFT_COUNT: begin
                shift_ena <= 1;
                if (sequence_count < 4) begin
                    sequence_count <= sequence_count + 1;
                    next_state <= SHIFT_COUNT;
                end
                else begin
                    shift_ena <= 0;
                    sequence_count <= 0;
                    counting <= 1;
                    next_state <= WAIT_FOR_TIMER;
                end
            end
            WAIT_FOR_TIMER: begin
                if (done_counting) begin
                    counting <= 0;
                    done <= 1;
                    next_state <= WAIT_FOR_ACK;
                end
                else begin
                    next_state <= WAIT_FOR_TIMER;
                end
            end
            WAIT_FOR_ACK: begin
                if (ack) begin
                    done <= 0;
                    next_state <= IDLE;
                end
                else begin
                    next_state <= WAIT_FOR_ACK;
                end
            end
            default: begin
                next_state <= IDLE;
            end
        endcase
    end
end

endmodule

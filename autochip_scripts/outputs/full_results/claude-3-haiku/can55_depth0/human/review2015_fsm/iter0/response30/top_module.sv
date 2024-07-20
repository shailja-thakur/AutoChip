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
                 COUNTING = 4'b0011,
                 WAIT_ACK = 4'b0100;

reg [3:0] state, next_state;
reg [3:0] shift_count;

always @(posedge clk or posedge reset) begin
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
                    shift_count <= 4'b1101;
                end
                else begin
                    shift_count <= {shift_count[2:0], data};
                end
            end
            SHIFT_DURATION: begin
                shift_ena <= 1;
                shift_count <= {shift_count[2:0], data};
                if (shift_count == 4'b0000) begin
                    shift_ena <= 0;
                    counting <= 1;
                end
            end
            COUNTING: begin
                if (done_counting) begin
                    counting <= 0;
                    done <= 1;
                end
            end
            WAIT_ACK: begin
                if (ack) begin
                    done <= 0;
                end
            end
        endcase
    end
end

always @(*) begin
    case (state)
        IDLE: next_state = (shift_count == 4'b1101) ? START_DETECT : IDLE;
        START_DETECT: next_state = (shift_count == 4'b0000) ? SHIFT_DURATION : START_DETECT;
        SHIFT_DURATION: next_state = COUNTING;
        COUNTING: next_state = (done_counting) ? WAIT_ACK : COUNTING;
        WAIT_ACK: next_state = (ack) ? IDLE : WAIT_ACK;
        default: next_state = IDLE;
    endcase
end

endmodule

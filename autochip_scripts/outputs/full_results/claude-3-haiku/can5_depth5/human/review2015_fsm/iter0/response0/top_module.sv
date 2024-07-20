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
                 START_SEQ = 4'b0001,
                 SHIFT_DURATION = 4'b0010,
                 COUNTING = 4'b0011,
                 NOTIFY_USER = 4'b0100,
                 WAIT_ACK = 4'b0101;

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
                if (data == 1'b1) begin
                    next_state <= START_SEQ;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            START_SEQ: begin
                if (data == 1'b1) begin
                    next_state <= START_SEQ;
                end
                else if (data == 1'b0) begin
                    shift_count <= 0;
                    next_state <= SHIFT_DURATION;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            SHIFT_DURATION: begin
                shift_ena <= 1;
                shift_count <= shift_count + 1;
                if (shift_count == 4'b0100) begin
                    shift_ena <= 0;
                    next_state <= COUNTING;
                end
                else begin
                    next_state <= SHIFT_DURATION;
                end
            end
            COUNTING: begin
                counting <= 1;
                if (done_counting) begin
                    counting <= 0;
                    next_state <= NOTIFY_USER;
                end
                else begin
                    next_state <= COUNTING;
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
                else begin
                    next_state <= WAIT_ACK;
                end
            end
            default: begin
                next_state <= IDLE;
            end
        endcase
    end
end

endmodule

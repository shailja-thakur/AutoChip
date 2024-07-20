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

parameter STATE_WAIT_FOR_START = 3'b000;
parameter STATE_SHIFT_DURATION = 3'b001;
parameter STATE_COUNT = 3'b010;
parameter STATE_NOTIFY = 3'b011;
parameter STATE_WAIT_FOR_ACK = 3'b100;

reg [2:0] state, next_state;
reg [3:0] shift_count;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_WAIT_FOR_START;
        shift_count <= 0;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            STATE_WAIT_FOR_START: begin
                shift_count <= 0;
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
                if (data == 1'b1) begin
                    if (shift_count == 4'b1101) begin
                        next_state <= STATE_SHIFT_DURATION;
                    end
                    else begin
                        shift_count <= {shift_count[2:0], data};
                    end
                end
                else begin
                    shift_count <= 0;
                end
            end
            STATE_SHIFT_DURATION: begin
                shift_ena <= 1;
                if (shift_count == 4'b0100) begin
                    shift_ena <= 0;
                    next_state <= STATE_COUNT;
                end
                else begin
                    shift_count <= shift_count + 1;
                end
            end
            STATE_COUNT: begin
                counting <= 1;
                if (done_counting) begin
                    counting <= 0;
                    next_state <= STATE_NOTIFY;
                end
            end
            STATE_NOTIFY: begin
                done <= 1;
                next_state <= STATE_WAIT_FOR_ACK;
            end
            STATE_WAIT_FOR_ACK: begin
                done <= 1;
                if (ack) begin
                    next_state <= STATE_WAIT_FOR_START;
                end
            end
        endcase
    end
end

endmodule

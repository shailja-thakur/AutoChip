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
                 DETECT_PATTERN = 4'b0001,
                 SHIFT_DURATION = 4'b0010,
                 COUNTING = 4'b0011,
                 NOTIFY_DONE = 4'b0100,
                 WAIT_FOR_ACK = 4'b0101;

reg [3:0] state, next_state;
reg [3:0] pattern_reg;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        pattern_reg <= 4'b0;
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end
    else begin
        state <= next_state;
        pattern_reg <= {pattern_reg[2:0], data};
        case (state)
            IDLE: begin
                shift_ena <= 1'b0;
                counting <= 1'b0;
                done <= 1'b0;
            end
            DETECT_PATTERN: begin
                if (pattern_reg == 4'b1101) begin
                    next_state <= SHIFT_DURATION;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            SHIFT_DURATION: begin
                shift_ena <= 1'b1;
                if (pattern_reg[3:0] == 4'b0000) begin
                    next_state <= COUNTING;
                    shift_ena <= 1'b0;
                end
                else begin
                    next_state <= SHIFT_DURATION;
                end
            end
            COUNTING: begin
                counting <= 1'b1;
                if (done_counting) begin
                    next_state <= NOTIFY_DONE;
                    counting <= 1'b0;
                end
                else begin
                    next_state <= COUNTING;
                end
            end
            NOTIFY_DONE: begin
                done <= 1'b1;
                next_state <= WAIT_FOR_ACK;
            end
            WAIT_FOR_ACK: begin
                if (ack) begin
                    next_state <= IDLE;
                    done <= 1'b0;
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

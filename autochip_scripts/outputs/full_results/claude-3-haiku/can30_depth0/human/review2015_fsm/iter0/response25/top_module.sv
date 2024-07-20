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

localparam [2:0] 
    IDLE = 3'd0,
    START_DETECTED = 3'd1,
    SHIFT_IN_DURATION = 3'd2, 
    COUNTING = 3'd3,
    TIMER_DONE = 3'd4;

reg [2:0] state, next_state;
reg [3:0] shift_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        shift_reg <= 0;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                shift_reg <= {shift_reg[2:0], data};
                if (shift_reg == 4'b1101) begin
                    next_state <= START_DETECTED;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            START_DETECTED: begin
                shift_ena <= 1;
                next_state <= SHIFT_IN_DURATION;
            end
            SHIFT_IN_DURATION: begin
                shift_reg <= {shift_reg[2:0], data};
                shift_ena <= 1;
                if (shift_ena == 1 && shift_reg[3:0] == 4'h0) begin
                    next_state <= COUNTING;
                    shift_ena <= 0;
                end
                else begin
                    next_state <= SHIFT_IN_DURATION;
                end
            end
            COUNTING: begin
                counting <= 1;
                if (done_counting) begin
                    next_state <= TIMER_DONE;
                    counting <= 0;
                end
                else begin
                    next_state <= COUNTING;
                end
            end
            TIMER_DONE: begin
                done <= 1;
                if (ack) begin
                    next_state <= IDLE;
                    done <= 0;
                end
                else begin
                    next_state <= TIMER_DONE;
                end
            end
            default: next_state <= IDLE;
        endcase
    end
end

endmodule

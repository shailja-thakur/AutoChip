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

localparam SEARCH_PATTERN = 4'b1101;
localparam WAIT_DURATION = 4'b0000;

reg [3:0] pattern_shift;
reg [3:0] duration_shift;

typedef enum reg [1:0] {
    SEARCH,
    SHIFT_DURATION,
    COUNT,
    NOTIFY
} state_t;

state_t state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= SEARCH;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
        pattern_shift <= 0;
        duration_shift <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            SEARCH: begin
                pattern_shift <= {pattern_shift[2:0], data};
                if (pattern_shift == SEARCH_PATTERN) begin
                    next_state = SHIFT_DURATION;
                    shift_ena <= 1;
                end
                else begin
                    next_state = SEARCH;
                    shift_ena <= 0;
                end
                counting <= 0;
                done <= 0;
            end
            SHIFT_DURATION: begin
                duration_shift <= {duration_shift[2:0], data};
                if (duration_shift == WAIT_DURATION) begin
                    next_state = COUNT;
                    shift_ena <= 0;
                end
                else begin
                    next_state = SHIFT_DURATION;
                    shift_ena <= 1;
                end
                counting <= 0;
                done <= 0;
            end
            COUNT: begin
                shift_ena <= 0;
                counting <= 1;
                if (done_counting) begin
                    next_state = NOTIFY;
                    counting <= 0;
                end
                else begin
                    next_state = COUNT;
                end
                done <= 0;
            end
            NOTIFY: begin
                shift_ena <= 0;
                counting <= 0;
                done <= 1;
                if (ack) begin
                    next_state = SEARCH;
                end
                else begin
                    next_state = NOTIFY;
                end
            end
        endcase
    end
end

endmodule

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

localparam STATE_WAIT_START = 0;
localparam STATE_SHIFT_IN = 1;
localparam STATE_COUNTING = 2;
localparam STATE_TIMER_DONE = 3;

reg [1:0] state;
reg [3:0] bit_count;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_WAIT_START;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
        bit_count <= 0;
    end else begin
        case (state)
            STATE_WAIT_START: begin
                // Wait for the start sequence 1101
                if (data == 1 && bit_count == 0) begin
                    bit_count <= 1;
                end else if (data == 1 && bit_count == 1) begin
                    bit_count <= 2;
                end else if (data == 0 && bit_count == 2) begin
                    bit_count <= 3;
                end else if (data == 1 && bit_count == 3) begin
                    state <= STATE_SHIFT_IN;
                    bit_count <= 0;
                    shift_ena <= 1;
                end else begin
                    bit_count <= 0;
                end
            end
            STATE_SHIFT_IN: begin
                // Shift in 4 more bits
                if (bit_count == 4) begin
                    state <= STATE_COUNTING;
                    shift_ena <= 0;
                    counting <= 1;
                end else begin
                    bit_count <= bit_count + 1;
                end
            end
            STATE_COUNTING: begin
                // Wait for the counters to finish
                if (done_counting) begin
                    state <= STATE_TIMER_DONE;
                    counting <= 0;
                    done <= 1;
                end
            end
            STATE_TIMER_DONE: begin
                // Wait for the user to acknowledge
                if (ack) begin
                    state <= STATE_WAIT_START;
                    done <= 0;
                end
            end
        endcase
    end
end

endmodule

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

localparam [3:0] WAIT_START = 4'd0,
                 SHIFT_ENABLE = 4'd1,
                 COUNTING = 4'd2,
                 WAIT_ACK = 4'd3;

reg [3:0] state, next_state;
reg [3:0] bit_count;
reg [3:0] pattern;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        bit_count <= 0;
        pattern <= 0;
    end
    else begin
        state <= next_state;
        if (state == WAIT_START) begin
            pattern <= {pattern[2:0], data};
            bit_count <= bit_count + 1;
            if (pattern == 4'b1101) begin
                next_state <= SHIFT_ENABLE;
                bit_count <= 0;
            end
            else begin
                next_state <= WAIT_START;
            end
        end
        else if (state == SHIFT_ENABLE) begin
            shift_ena <= 1;
            bit_count <= bit_count + 1;
            if (bit_count == 4) begin
                shift_ena <= 0;
                next_state <= COUNTING;
            end
            else begin
                next_state <= SHIFT_ENABLE;
            end
        end
        else if (state == COUNTING) begin
            counting <= 1;
            if (done_counting) begin
                counting <= 0;
                next_state <= WAIT_ACK;
            end
            else begin
                next_state <= COUNTING;
            end
        end
        else if (state == WAIT_ACK) begin
            done <= 1;
            if (ack) begin
                done <= 0;
                next_state <= WAIT_START;
            end
            else begin
                next_state <= WAIT_ACK;
            end
        end
    end
end

endmodule

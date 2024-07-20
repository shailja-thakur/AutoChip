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

localparam [3:0] S_IDLE = 4'b0000,
                 S_START_DETECT = 4'b0001,
                 S_SHIFT_COUNT = 4'b0010,
                 S_COUNTING = 4'b0011,
                 S_DONE = 4'b0100;

reg [3:0] state, next_state;
reg [3:0] bit_count;

always @(posedge clk) begin
    if (reset) begin
        state <= S_IDLE;
        bit_count <= 0;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            S_IDLE: begin
                bit_count <= 0;
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
            S_START_DETECT: begin
                if (bit_count == 4 && data == 1'b1) begin
                    next_state <= S_SHIFT_COUNT;
                    bit_count <= 0;
                    shift_ena <= 1;
                end
                else begin
                    bit_count <= bit_count + 1;
                end
            end
            S_SHIFT_COUNT: begin
                if (bit_count == 3) begin
                    next_state <= S_COUNTING;
                    shift_ena <= 0;
                    counting <= 1;
                end
                else begin
                    bit_count <= bit_count + 1;
                end
            end
            S_COUNTING: begin
                if (done_counting) begin
                    next_state <= S_DONE;
                    counting <= 0;
                    done <= 1;
                end
            end
            S_DONE: begin
                if (ack) begin
                    next_state <= S_IDLE;
                end
            end
            default: begin
                next_state <= S_IDLE;
            end
        endcase
    end
end

endmodule

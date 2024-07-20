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

localparam [3:0] IDLE = 4'd0, START_DETECT = 4'd1, SHIFT = 4'd2, COUNT = 4'd3, NOTIFY = 4'd4;
reg [3:0] state, next_state;
reg [3:0] bit_count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end else begin
        state <= next_state;
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    bit_count <= 1;
                    next_state <= START_DETECT;
                end else begin
                    bit_count <= 0;
                    next_state <= IDLE;
                end
            end
            START_DETECT: begin
                if (data == 1'b1 && bit_count == 1) begin
                    bit_count <= 2;
                    next_state <= START_DETECT;
                end else if (data == 1'b0 && bit_count == 2) begin
                    bit_count <= 3;
                    next_state <= START_DETECT;
                end else if (data == 1'b1 && bit_count == 3) begin
                    bit_count <= 4;
                    next_state <= SHIFT;
                end else begin
                    bit_count <= 0;
                    next_state <= IDLE;
                end
            end
            SHIFT: begin
                shift_ena <= 1;
                if (bit_count < 8) begin
                    bit_count <= bit_count + 1;
                    next_state <= SHIFT;
                end else begin
                    shift_ena <= 0;
                    bit_count <= 0;
                    next_state <= COUNT;
                end
            end
            COUNT: begin
                counting <= 1;
                if (done_counting) begin
                    counting <= 0;
                    next_state <= NOTIFY;
                end else begin
                    next_state <= COUNT;
                end
            end
            NOTIFY: begin
                done <= 1;
                if (ack) begin
                    done <= 0;
                    next_state <= IDLE;
                end else begin
                    next_state <= NOTIFY;
                end
            end
            default: begin
                next_state <= IDLE;
            end
        endcase
    end
end

endmodule

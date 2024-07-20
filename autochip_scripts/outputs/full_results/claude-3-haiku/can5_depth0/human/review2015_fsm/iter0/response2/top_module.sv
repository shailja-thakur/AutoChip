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

localparam [1:0] IDLE = 2'b00, DETECT = 2'b01, SHIFT = 2'b10, WAIT = 2'b11;
reg [1:0] state, next_state;
reg [3:0] bit_count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    bit_count <= 1;
                    next_state <= DETECT;
                end
                else begin
                    bit_count <= 0;
                    next_state <= IDLE;
                end
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
            DETECT: begin
                if (data == 1'b1 && bit_count == 1) begin
                    bit_count <= 2;
                    next_state <= DETECT;
                end
                else if (data == 1'b0 && bit_count == 2) begin
                    bit_count <= 3;
                    next_state <= DETECT;
                end
                else if (data == 1'b1 && bit_count == 3) begin
                    bit_count <= 4;
                    next_state <= SHIFT;
                end
                else begin
                    bit_count <= 0;
                    next_state <= IDLE;
                end
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
            SHIFT: begin
                if (bit_count < 8) begin
                    bit_count <= bit_count + 1;
                    next_state <= SHIFT;
                    shift_ena <= 1;
                end
                else begin
                    bit_count <= 0;
                    next_state <= WAIT;
                    shift_ena <= 0;
                end
                counting <= 0;
                done <= 0;
            end
            WAIT: begin
                if (done_counting) begin
                    next_state <= IDLE;
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 1;
                end
                else begin
                    next_state <= WAIT;
                    shift_ena <= 0;
                    counting <= 1;
                    done <= 0;
                end
            end
            default: begin
                next_state <= IDLE;
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
        endcase
    end
end

endmodule

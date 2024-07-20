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

reg [3:0] state;
parameter [3:0] WAIT_START = 4'b0000,
                SHIFT_DURATION = 4'b0001,
                COUNT = 4'b0010,
                NOTIFY = 4'b0011,
                WAIT_ACK = 4'b0100;

reg [3:0] shift_count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= WAIT_START;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
        shift_count <= 0;
    end
    else begin
        case (state)
            WAIT_START: begin
                if (data == 1'b1 && {data, data, data, data} == 4'b1101) begin
                    state <= SHIFT_DURATION;
                    shift_count <= 0;
                end
                else begin
                    state <= WAIT_START;
                end
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
            SHIFT_DURATION: begin
                if (shift_count < 4) begin
                    shift_ena <= 1;
                    shift_count <= shift_count + 1;
                end
                else begin
                    shift_ena <= 0;
                    state <= COUNT;
                end
                counting <= 0;
                done <= 0;
            end
            COUNT: begin
                if (done_counting) begin
                    state <= NOTIFY;
                end
                else begin
                    state <= COUNT;
                end
                shift_ena <= 0;
                counting <= 1;
                done <= 0;
            end
            NOTIFY: begin
                if (ack) begin
                    state <= WAIT_START;
                end
                else begin
                    state <= NOTIFY;
                end
                shift_ena <= 0;
                counting <= 0;
                done <= 1;
            end
            default: begin
                state <= WAIT_START;
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
        endcase
    end
end

endmodule

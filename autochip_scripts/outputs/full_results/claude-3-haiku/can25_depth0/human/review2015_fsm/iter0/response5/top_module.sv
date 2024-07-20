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
reg [3:0] shift_count;

localparam IDLE = 4'b0000;
localparam DETECT_START = 4'b0001;
localparam SHIFT_DURATION = 4'b0010;
localparam COUNT_DURATION = 4'b0011;
localparam NOTIFY_USER = 4'b0100;
localparam WAIT_ACK = 4'b0101;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
        shift_count <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    state <= DETECT_START;
                end
            end
            DETECT_START: begin
                if (data == 1'b1) begin
                    state <= DETECT_START;
                end
                else if (data == 1'b0) begin
                    state <= SHIFT_DURATION;
                    shift_count <= 0;
                    shift_ena <= 1;
                end
            end
            SHIFT_DURATION: begin
                shift_count <= shift_count + 1;
                if (shift_count == 3) begin
                    shift_ena <= 0;
                    state <= COUNT_DURATION;
                    counting <= 1;
                end
            end
            COUNT_DURATION: begin
                if (done_counting) begin
                    counting <= 0;
                    state <= NOTIFY_USER;
                    done <= 1;
                end
            end
            NOTIFY_USER: begin
                if (ack) begin
                    done <= 0;
                    state <= IDLE;
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule

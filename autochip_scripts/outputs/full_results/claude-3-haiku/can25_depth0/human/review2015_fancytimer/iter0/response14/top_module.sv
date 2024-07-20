module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

reg [3:0] delay;
reg [3:0] timer_count;
reg [3:0] state;

localparam IDLE = 0;
localparam DETECT_PATTERN = 1;
localparam CAPTURE_DELAY = 2;
localparam COUNTING = 3;
localparam WAIT_ACK = 4;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
        delay <= 0;
        timer_count <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    state <= DETECT_PATTERN;
                end
                else begin
                    state <= IDLE;
                end
            end

            DETECT_PATTERN: begin
                if (data == 1'b1) begin
                    state <= DETECT_PATTERN;
                end
                else if (data == 1'b0) begin
                    state <= CAPTURE_DELAY;
                    delay[3] <= data;
                end
                else begin
                    state <= IDLE;
                end
            end

            CAPTURE_DELAY: begin
                delay[2] <= data;
                delay[1] <= data;
                delay[0] <= data;
                state <= COUNTING;
            end

            COUNTING: begin
                counting <= 1;
                if (timer_count < (delay + 1)*1000 - 1) begin
                    timer_count <= timer_count + 1;
                end
                else begin
                    counting <= 0;
                    done <= 1;
                    state <= WAIT_ACK;
                end
            end

            WAIT_ACK: begin
                if (ack) begin
                    state <= IDLE;
                    done <= 0;
                end
            end

            default: begin
                state <= IDLE;
            end
        endcase
    end
end

assign count = timer_count % 1000 == 0 ? delay : delay - timer_count / 1000;

endmodule

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
reg [3:0] timer;
reg [3:0] state;
reg [3:0] pattern;

localparam IDLE = 4'b0000;
localparam DETECT_PATTERN = 4'b0001;
localparam LOAD_DELAY = 4'b0010;
localparam COUNT = 4'b0011;
localparam NOTIFY = 4'b0100;
localparam WAIT_ACK = 4'b0101;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        pattern <= 0;
        delay <= 0;
        timer <= 0;
        counting <= 0;
        done <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    pattern <= {pattern[2:0], data};
                    if (pattern == 4'b1101) begin
                        state <= DETECT_PATTERN;
                    end
                end else begin
                    pattern <= {pattern[2:0], data};
                end
            end

            DETECT_PATTERN: begin
                if (data == 1'b1) begin
                    pattern <= {pattern[2:0], data};
                end else begin
                    pattern <= {pattern[2:0], data};
                    state <= LOAD_DELAY;
                end
            end

            LOAD_DELAY: begin
                if (data == 1'b1) begin
                    delay <= {delay[2:0], data};
                end else begin
                    delay <= {delay[2:0], data};
                    state <= COUNT;
                    counting <= 1;
                    timer <= delay + 1;
                end
            end

            COUNT: begin
                timer <= timer - 1;
                if (timer == 0) begin
                    counting <= 0;
                    state <= NOTIFY;
                    done <= 1;
                end
            end

            NOTIFY: begin
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

assign count = (state == COUNT) ? timer : 0;

endmodule

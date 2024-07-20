module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam IDLE = 2'b00, DETECT = 2'b01, TIMER = 2'b10, NOTIFY = 2'b11;
reg [1:0] state;
reg [3:0] pattern;
reg [3:0] delay;
reg [15:0] timer;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        pattern <= 4'b0;
        delay <= 4'b0;
        timer <= 16'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (pattern == 4'b1101) begin
                    state <= DETECT;
                    pattern <= 4'b0;
                end
                else begin
                    pattern <= {pattern[2:0], data};
                end
            end
            DETECT: begin
                if (pattern == 4'b0) begin
                    delay <= {data, data, data, data};
                    timer <= (delay + 1) * 16'd1000;
                    state <= TIMER;
                    counting <= 1'b1;
                end
                else begin
                    pattern <= {pattern[2:0], data};
                end
            end
            TIMER: begin
                if (timer == 16'b0) begin
                    state <= NOTIFY;
                    counting <= 1'b0;
                    done <= 1'b1;
                end
                else begin
                    timer <= timer - 1;
                end
            end
            NOTIFY: begin
                if (ack) begin
                    state <= IDLE;
                    done <= 1'b0;
                end
            end
            default: state <= IDLE;
        endcase
    end
end

assign count = delay - (timer / 16'd1000);

endmodule

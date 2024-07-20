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
reg [3:0] counter;
reg [3:0] state;
reg [3:0] pattern;

localparam [3:0] IDLE = 4'd0;
localparam [3:0] DETECT_PATTERN = 4'd1;
localparam [3:0] CAPTURE_DELAY = 4'd2;
localparam [3:0] COUNT_DOWN = 4'd3;
localparam [3:0] NOTIFY_DONE = 4'd4;
localparam [3:0] WAIT_ACK = 4'd5;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        pattern <= 4'b0;
        delay <= 4'b0;
        counter <= 4'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    pattern[3] <= pattern[2];
                    pattern[2] <= pattern[1];
                    pattern[1] <= pattern[0];
                    pattern[0] <= data;
                    if (pattern == 4'b1101) begin
                        state <= DETECT_PATTERN;
                    end
                end
            end
            DETECT_PATTERN: begin
                delay[3] <= data;
                delay[2] <= data;
                delay[1] <= data;
                delay[0] <= data;
                state <= CAPTURE_DELAY;
            end
            CAPTURE_DELAY: begin
                counter <= delay + 4'b0001;
                state <= COUNT_DOWN;
                counting <= 1'b1;
            end
            COUNT_DOWN: begin
                if (counter == 4'b0000) begin
                    counting <= 1'b0;
                    state <= NOTIFY_DONE;
                end
                else begin
                    counter <= counter - 4'b0001;
                end
            end
            NOTIFY_DONE: begin
                done <= 1'b1;
                state <= WAIT_ACK;
            end
            WAIT_ACK: begin
                if (ack) begin
                    done <= 1'b0;
                    state <= IDLE;
                end
            end
        endcase
    end
end

assign count = counter;

endmodule

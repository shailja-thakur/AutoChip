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
reg [3:0] pattern;
reg [1:0] state;

localparam WAIT_PATTERN = 2'b00;
localparam CAPTURE_DELAY = 2'b01;
localparam COUNT_DOWN = 2'b10;
localparam NOTIFY_DONE = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_PATTERN;
        counting <= 0;
        done <= 0;
        pattern <= 4'b0;
    end else begin
        case (state)
            WAIT_PATTERN: begin
                if (pattern == 4'b1101) begin
                    state <= CAPTURE_DELAY;
                    pattern <= 4'b0;
                end else begin
                    pattern <= {pattern[2:0], data};
                end
                counting <= 0;
            end
            CAPTURE_DELAY: begin
                delay <= {data, delay[3:1]};
                if (delay == 4'b0000) begin
                    state <= COUNT_DOWN;
                    counter <= 4'b0000;
                    counting <= 1;
                end
            end
            COUNT_DOWN: begin
                counter <= counter + 1;
                if (counter == delay) begin
                    state <= NOTIFY_DONE;
                    counting <= 0;
                    done <= 1;
                end
            end
            NOTIFY_DONE: begin
                if (ack) begin
                    state <= WAIT_PATTERN;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = (state == COUNT_DOWN) ? delay - counter : 4'bxxxx;

endmodule

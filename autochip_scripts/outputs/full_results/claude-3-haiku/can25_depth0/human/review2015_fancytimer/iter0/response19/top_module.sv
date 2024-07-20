module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam IDLE = 3'b000, WAIT_PATTERN = 3'b001, WAIT_DURATION = 3'b010, COUNT = 3'b011, NOTIFY = 3'b100;
reg [2:0] state;
reg [3:0] pattern;
reg [3:0] delay;
reg [12:0] counter;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
        pattern <= 4'b0;
        delay <= 4'b0;
        counter <= 13'b0;
    end else begin
        case (state)
            IDLE: begin
                if (pattern == 4'b1101) begin
                    state <= WAIT_DURATION;
                    pattern <= 4'b0;
                end else begin
                    pattern <= {pattern[2:0], data};
                end
            end
            WAIT_DURATION: begin
                if (pattern == 4'b0) begin
                    delay <= {data, pattern[3:1]};
                    state <= COUNT;
                    counting <= 1;
                    counter <= 13'b0;
                end else begin
                    pattern <= {pattern[2:0], data};
                end
            end
            COUNT: begin
                counter <= counter + 13'd1;
                if (counter == (delay + 1) * 13'd1000 - 1) begin
                    state <= NOTIFY;
                    counting <= 0;
                end
            end
            NOTIFY: begin
                done <= 1;
                if (ack) begin
                    state <= IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = (state == COUNT) ? delay - (counter / 13'd1000) : 4'b0;

endmodule

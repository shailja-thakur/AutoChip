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

parameter IDLE = 4'd0;
parameter DETECT_PATTERN = 4'd1;
parameter LOAD_DELAY = 4'd2;
parameter COUNT = 4'd3;
parameter WAIT_ACK = 4'd4;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
        pattern <= 4'b0000;
        delay <= 4'b0000;
        counter <= 4'b0000;
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
                    delay[3] <= data;
                    state <= LOAD_DELAY;
                end else begin
                    delay[3] <= data;
                end
            end
            LOAD_DELAY: begin
                delay[2:0] <= {delay[1:0], data};
                if (delay[2:0] == 3'b111) begin
                    state <= COUNT;
                    counting <= 1;
                    counter <= delay + 1;
                end
            end
            COUNT: begin
                if (counter == 0) begin
                    counting <= 0;
                    done <= 1;
                    state <= WAIT_ACK;
                end else begin
                    counter <= counter - 1;
                end
            end
            WAIT_ACK: begin
                if (ack) begin
                    state <= IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = (state == COUNT) ? counter : 4'bxxxx;

endmodule

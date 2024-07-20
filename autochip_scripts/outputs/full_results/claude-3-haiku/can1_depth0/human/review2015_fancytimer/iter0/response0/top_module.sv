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

localparam IDLE = 4'b0000;
localparam DETECT_PATTERN = 4'b0001;
localparam READ_DELAY = 4'b0010;
localparam COUNTING = 4'b0011;
localparam WAIT_ACK = 4'b0100;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
        pattern <= 0;
        delay <= 0;
        counter <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    pattern <= {pattern[2:0], data};
                    if (pattern == 4'b1101) begin
                        state <= DETECT_PATTERN;
                    end
                end
                else begin
                    pattern <= {pattern[2:0], data};
                end
            end
            DETECT_PATTERN: begin
                if (data == 1'b1) begin
                    pattern <= {pattern[2:0], data};
                end
                else begin
                    pattern <= {pattern[2:0], data};
                    state <= READ_DELAY;
                end
            end
            READ_DELAY: begin
                delay <= {data, delay[3:1]};
                if (delay[0]) begin
                    state <= COUNTING;
                    counter <= delay;
                    counting <= 1;
                end
            end
            COUNTING: begin
                if (counter == 0) begin
                    counting <= 0;
                    done <= 1;
                    state <= WAIT_ACK;
                end
                else begin
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

assign count = (state == COUNTING) ? counter : 4'bxxxx;

endmodule

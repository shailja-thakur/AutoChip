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

localparam WAIT_START = 2'b00;
localparam CAPTURE_DELAY = 2'b01;
localparam COUNT_DOWN = 2'b10;
localparam WAIT_ACK = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        pattern <= 4'b0000;
        delay <= 4'b0000;
        counter <= 4'b0000;
        counting <= 1'b0;
        done <= 1'b0;
    end
    else begin
        case (state)
            WAIT_START: begin
                if (pattern == 4'b1101) begin
                    state <= CAPTURE_DELAY;
                    pattern <= 4'b0000;
                end
                else begin
                    pattern <= {pattern[2:0], data};
                end
            end
            CAPTURE_DELAY: begin
                if (counter == 4'b0000) begin
                    delay <= {data, delay[3:1]};
                    counter <= 4'b1000;
                    state <= COUNT_DOWN;
                    counting <= 1'b1;
                end
                else begin
                    counter <= counter - 1;
                end
            end
            COUNT_DOWN: begin
                if (counter == 4'b0001) begin
                    state <= WAIT_ACK;
                    counting <= 1'b0;
                    done <= 1'b1;
                end
                else begin
                    counter <= counter - 1;
                end
            end
            WAIT_ACK: begin
                if (ack) begin
                    state <= WAIT_START;
                    done <= 1'b0;
                end
            end
            default: begin
                state <= WAIT_START;
            end
        endcase
    end
end

assign count = (state == COUNT_DOWN) ? (delay - counter + 1) : 4'b0000;

endmodule

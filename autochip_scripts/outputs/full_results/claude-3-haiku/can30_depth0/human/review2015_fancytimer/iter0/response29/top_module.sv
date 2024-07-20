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
localparam READ_DELAY = 2'b01;
localparam COUNT_DOWN = 2'b10;
localparam WAIT_ACK = 2'b11;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        pattern <= 4'b0000;
        delay <= 4'b0000;
        counter <= 4'b0000;
        counting <= 1'b0;
        done <= 1'b0;
        state <= WAIT_START;
    end else begin
        case (state)
            WAIT_START: begin
                if (pattern == 4'b1101) begin
                    pattern <= 4'b0000;
                    state <= READ_DELAY;
                end else begin
                    pattern <= {pattern[2:0], data};
                end
            end
            READ_DELAY: begin
                if (counter == 4'b0100) begin
                    delay <= {data, delay[3:1]};
                    counter <= 4'b0000;
                    state <= COUNT_DOWN;
                    counting <= 1'b1;
                end else begin
                    counter <= counter + 1;
                end
            end
            COUNT_DOWN: begin
                if (counter == delay) begin
                    counter <= 4'b0000;
                    if (delay == 4'b0000) begin
                        state <= WAIT_ACK;
                        counting <= 1'b0;
                        done <= 1'b1;
                    end else begin
                        delay <= delay - 1;
                    end
                end else begin
                    counter <= counter + 1;
                end
            end
            WAIT_ACK: begin
                if (ack) begin
                    state <= WAIT_START;
                    done <= 1'b0;
                end
            end
        endcase
    end
end

assign count = delay;

endmodule

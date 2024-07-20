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

localparam IDLE = 4'b0000;
localparam DETECT_START = 4'b0001;
localparam CAPTURE_DELAY = 4'b0010;
localparam COUNT_DOWN = 4'b0011;
localparam WAIT_ACK = 4'b0100;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (data == 1'b1 && counter == 4'b1101) begin
                    state <= CAPTURE_DELAY;
                    counter <= 0;
                end else if (data == 1'b1) begin
                    counter <= {counter[2:0], data};
                end else begin
                    counter <= 0;
                end
            end
            CAPTURE_DELAY: begin
                if (counter == 4'b0000) begin
                    delay <= {data, delay[3:1]};
                    counter <= 4'b1000;
                    state <= COUNT_DOWN;
                    counting <= 1;
                end else begin
                    counter <= counter - 1;
                end
            end
            COUNT_DOWN: begin
                if (counter == 0) begin
                    if (delay == 0) begin
                        state <= WAIT_ACK;
                        counting <= 0;
                        done <= 1;
                    end else begin
                        delay <= delay - 1;
                        counter <= 4'b1000;
                    end
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

assign count = (state == COUNT_DOWN) ? delay : 4'bxxxx;

endmodule

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

localparam IDLE = 2'b00;
localparam DETECT = 2'b01;
localparam COUNT = 2'b10;
localparam COMPLETE = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
        pattern <= 0;
        delay <= 0;
        counter <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (data == 1'b1) pattern[3:0] <= {pattern[2:0], data};
                if (pattern == 4'b1101) begin
                    state <= DETECT;
                    pattern <= 0;
                end
            end
            DETECT: begin
                if (data == 1'b1) pattern[3:0] <= {pattern[2:0], data};
                if (pattern == 4'b0) begin
                    delay[3:0] <= 4'b0;
                    state <= COUNT;
                    counting <= 1;
                end else begin
                    delay[3:0] <= {delay[2:0], data};
                end
            end
            COUNT: begin
                if (counter == 0) begin
                    counter <= delay + 1;
                    count[3:0] <= delay;
                end else begin
                    counter <= counter - 1;
                    count[3:0] <= counter - 1;
                end
                if (counter == 1) begin
                    state <= COMPLETE;
                    counting <= 0;
                    done <= 1;
                end
            end
            COMPLETE: begin
                if (ack) begin
                    state <= IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

endmodule

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

localparam IDLE = 2'd0;
localparam DETECT = 2'd1;
localparam COUNT = 2'd2;
localparam WAIT = 2'd3;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 1'b0;
        done <= 1'b0;
        pattern <= 4'b0;
        delay <= 4'b0;
        counter <= 4'b0;
    end else begin
        case (state)
            IDLE: begin
                if (data == 1'b1 && pattern == 4'b1101) begin
                    state <= DETECT;
                end else begin
                    pattern <= {pattern[2:0], data};
                end
            end
            DETECT: begin
                if (pattern == 4'b1101) begin
                    delay <= {data, data, data, data};
                    state <= COUNT;
                    counting <= 1'b1;
                    counter <= delay + 1;
                end else begin
                    state <= IDLE;
                end
            end
            COUNT: begin
                if (counter == 0) begin
                    state <= WAIT;
                    counting <= 1'b0;
                    done <= 1'b1;
                end else begin
                    counter <= counter - 1;
                end
            end
            WAIT: begin
                if (ack) begin
                    state <= IDLE;
                    done <= 1'b0;
                end
            end
        endcase
    end
end

assign count = counter;

endmodule

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
localparam DETECT_START = 2'b01;
localparam COUNT = 2'b10;
localparam DONE = 2'b11;

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
                else pattern <= 0;
                if (pattern == 4'b1101) begin
                    state <= DETECT_START;
                    pattern <= 0;
                end
                counting <= 0;
                done <= 0;
            end
            DETECT_START: begin
                if (data == 1'b1) delay[3:0] <= {delay[2:0], data};
                else delay <= 0;
                if (delay[3:0] != 0) begin
                    state <= COUNT;
                    counter <= delay;
                    counting <= 1;
                end
            end
            COUNT: begin
                if (counter != 0) begin
                    counter <= counter - 1;
                end else begin
                    state <= DONE;
                    counting <= 0;
                    done <= 1;
                end
            end
            DONE: begin
                if (ack) begin
                    state <= IDLE;
                end
            end
        endcase
    end
end

assign count = counter;

endmodule

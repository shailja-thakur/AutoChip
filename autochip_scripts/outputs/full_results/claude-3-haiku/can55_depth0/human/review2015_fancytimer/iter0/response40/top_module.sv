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
localparam COUNTDOWN = 2'b10;
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
                if (data == 1'b1 && pattern[3:0] == 4'b1101) begin
                    state <= DETECT;
                    pattern <= 0;
                end else begin
                    pattern <= {pattern[2:0], data};
                end
            end
            DETECT: begin
                if (counter < 4) begin
                    delay[3 - counter] <= data;
                    counter <= counter + 1;
                end else begin
                    state <= COUNTDOWN;
                    counting <= 1;
                    counter <= delay + 1;
                end
            end
            COUNTDOWN: begin
                if (counter == 0) begin
                    state <= DONE;
                    counting <= 0;
                    done <= 1;
                end else begin
                    counter <= counter - 1;
                end
            end
            DONE: begin
                if (ack) begin
                    state <= IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = delay - counter + 1;

endmodule

module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

reg [3:0] state;
reg [3:0] delay;
reg [3:0] counter;

localparam IDLE = 4'd0;
localparam START_DETECT = 4'd1;
localparam SHIFT_DELAY = 4'd2;
localparam COUNT = 4'd3;
localparam DONE = 4'd4;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
        counter <= 0;
        delay <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    state <= START_DETECT;
                end
                counting <= 0;
                done <= 0;
            end
            START_DETECT: begin
                if (data == 1'b1) begin
                    state <= START_DETECT;
                end
                else if (data == 1'b0) begin
                    state <= SHIFT_DELAY;
                end
                counting <= 0;
                done <= 0;
            end
            SHIFT_DELAY: begin
                delay[3] <= data;
                state <= SHIFT_DELAY;
                if (counter == 4'd3) begin
                    state <= COUNT;
                    counter <= 0;
                end
                else begin
                    counter <= counter + 1;
                end
                counting <= 0;
                done <= 0;
            end
            COUNT: begin
                if (counter == (delay + 1) * 4'd1000 - 1) begin
                    state <= DONE;
                    counter <= 0;
                end
                else begin
                    counter <= counter + 1;
                end
                counting <= 1;
                done <= 0;
            end
            DONE: begin
                if (ack) begin
                    state <= IDLE;
                end
                counting <= 0;
                done <= 1;
            end
        endcase
    end
end

assign count = (state == COUNT) ? delay - (counter / 1000) : 4'b0;

endmodule

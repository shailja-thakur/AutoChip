module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam STATE_IDLE = 3'b000;
localparam STATE_START = 3'b001;
localparam STATE_DELAY = 3'b010;
localparam STATE_COUNT = 3'b011;
localparam STATE_DONE = 3'b100;

reg [2:0] state;
reg [3:0] delay;
reg [19:0] counter;
reg [3:0] curr_count;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_IDLE;
        counting <= 0;
        done <= 0;
        delay <= 0;
        counter <= 0;
        curr_count <= 0;
    end else begin
        case (state)
            STATE_IDLE: begin
                if ({data, data, data, data} == 4'b1101) begin
                    state <= STATE_START;
                end
                counting <= 0;
                done <= 0;
            end
            STATE_START: begin
                delay[3] <= data;
                state <= STATE_DELAY;
            end
            STATE_DELAY: begin
                delay[2] <= data;
                delay[1] <= data;
                delay[0] <= data;
                state <= STATE_COUNT;
                counting <= 1;
                counter <= 0;
                curr_count <= delay;
            end
            STATE_COUNT: begin
                if (counter == (delay + 1) * 1000 - 1) begin
                    state <= STATE_DONE;
                    counting <= 0;
                    done <= 1;
                end else begin
                    counter <= counter + 1;
                    curr_count <= curr_count - 1;
                end
            end
            STATE_DONE: begin
                if (ack) begin
                    state <= STATE_IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = curr_count;

endmodule

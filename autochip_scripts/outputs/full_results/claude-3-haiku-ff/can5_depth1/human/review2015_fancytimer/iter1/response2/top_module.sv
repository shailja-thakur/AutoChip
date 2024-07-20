module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam STATE_IDLE = 3'd0;
localparam STATE_START = 3'd1;
localparam STATE_READ_DELAY = 3'd2;
localparam STATE_COUNT = 3'd3;
localparam STATE_DONE = 3'd4;

reg [2:0] state;
reg [3:0] delay;
reg [14:0] counter;
reg [3:0] data_shift;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= STATE_IDLE;
        counting <= 0;
        done <= 0;
        delay <= 0;
        counter <= 0;
        data_shift <= 0;
    end else begin
        case (state)
            STATE_IDLE: begin
                if (data_shift == 4'b1101) begin
                    state <= STATE_READ_DELAY;
                    data_shift <= 0;
                end else begin
                    data_shift <= {data_shift[2:0], data};
                end
            end
            STATE_READ_DELAY: begin
                if (data_shift != 4'b0000) begin
                    delay <= data_shift;
                    state <= STATE_COUNT;
                    counting <= 1;
                    counter <= 0;
                end else begin
                    data_shift <= {data_shift[2:0], data};
                end
            end
            STATE_COUNT: begin
                if (counter == (delay + 1) * 1000 - 1) begin
                    state <= STATE_DONE;
                    counting <= 0;
                    done <= 1;
                    counter <= 0;
                end else begin
                    counter <= counter + 1;
                end
            end
            STATE_DONE: begin
                if (ack == 1'b1) begin
                    state <= STATE_IDLE;
                    done <= 0;
                end
            end
            default: begin
                state <= STATE_IDLE;
            end
        endcase
    end
end

always @(*) begin
    if (state == STATE_COUNT) begin
        count = delay - (counter / 1000);
    end else begin
        count = 4'hx;
    end
end

endmodule

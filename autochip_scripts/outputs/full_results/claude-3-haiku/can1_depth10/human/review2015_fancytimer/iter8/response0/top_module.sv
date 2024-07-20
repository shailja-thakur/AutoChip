module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
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
reg [19:0] timer_count;
reg [3:0] data_shift;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_IDLE;
        counting <= 0;
        done <= 0;
        delay <= 0;
        counter <= 0;
        timer_count <= 0;
        count <= 0;
        data_shift <= 0;
    end else begin
        case (state)
            STATE_IDLE: begin
                data_shift <= {data, data_shift[3:1]};
                if (data_shift == 4'b1101) begin
                    state <= STATE_DELAY;
                end
                counting <= 0;
                done <= 0;
            end
            STATE_DELAY: begin
                data_shift <= {data, data_shift[3:1]};
                delay <= data_shift;
                state <= STATE_COUNT;
                counting <= 1;
                counter <= 0;
                timer_count <= (delay + 1) * 1000 - 1;
            end
            STATE_COUNT: begin
                if (counter == timer_count) begin
                    state <= STATE_DONE;
                    counting <= 0;
                    done <= 1;
                end else begin
                    counter <= counter + 1;
                    count <= timer_count - counter;
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

endmodule

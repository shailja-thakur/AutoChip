module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam STATE_IDLE = 0,
          STATE_DETECT_START = 1,
          STATE_CAPTURE_DELAY = 2,
          STATE_COUNTING = 3,
          STATE_DONE = 4;

reg [2:0] state, next_state;
reg [3:0] delay_counter, delay_value;
reg [3:0] count_down;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= STATE_IDLE;
        counting <= 0;
        done <= 0;
        delay_counter <= 0;
        delay_value <= 0;
        count_down <= 0;
    end else begin
        state <= next_state;

        case (state)
            STATE_IDLE: begin
                counting <= 0;
                done <= 0;
                delay_counter <= 0;
                delay_value <= 0;
                count_down <= 0;
            end
            STATE_DETECT_START: begin
                if (data) begin
                    delay_counter <= {delay_counter[2:0], data};
                    if (delay_counter == 4'b1101) begin
                        next_state <= STATE_CAPTURE_DELAY;
                    end
                end else begin
                    next_state <= STATE_IDLE;
                end
            end
            STATE_CAPTURE_DELAY: begin
                if (delay_counter < 4'b1111) begin
                    delay_value[delay_counter] <= data;
                    delay_counter <= delay_counter + 1;
                end else begin
                    next_state <= STATE_COUNTING;
                    counting <= 1;
                    count_down <= delay_value + 1;
                end
            end
            STATE_COUNTING: begin
                if (count_down > 0) begin
                    count_down <= count_down - 1;
                end else begin
                    next_state <= STATE_DONE;
                    counting <= 0;
                    done <= 1;
                end
            end
            STATE_DONE: begin
                if (ack) begin
                    next_state <= STATE_IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = count_down;

endmodule

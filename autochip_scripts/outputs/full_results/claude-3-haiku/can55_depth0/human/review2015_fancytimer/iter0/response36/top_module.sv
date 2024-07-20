module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam STATE_WAIT_PATTERN = 0,
          STATE_READ_DELAY = 1,
          STATE_COUNTING = 2,
          STATE_DONE = 3;

reg [1:0] state;
reg [3:0] shift_reg;
reg [3:0] delay;
reg [13:0] counter;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_WAIT_PATTERN;
        counting <= 0;
        done <= 0;
        shift_reg <= 0;
        delay <= 0;
        counter <= 0;
    end else begin
        case (state)
            STATE_WAIT_PATTERN: begin
                if (shift_reg[3:0] == 4'b1101) begin
                    state <= STATE_READ_DELAY;
                    shift_reg <= 0;
                end else begin
                    shift_reg <= {shift_reg[2:0], data};
                end
            end
            STATE_READ_DELAY: begin
                if (counter < 4) begin
                    delay[3-counter] <= data;
                    counter <= counter + 1;
                end else begin
                    state <= STATE_COUNTING;
                    counter <= 0;
                    counting <= 1;
                end
            end
            STATE_COUNTING: begin
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
                if (ack) begin
                    state <= STATE_WAIT_PATTERN;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = (state == STATE_COUNTING) ? delay - (counter / 1000) : 0;

endmodule

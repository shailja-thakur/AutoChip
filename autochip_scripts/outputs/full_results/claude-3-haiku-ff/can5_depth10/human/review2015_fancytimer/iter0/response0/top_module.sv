module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam STATE_IDLE = 3'd0;
localparam STATE_DETECT_START = 3'd1;
localparam STATE_CAPTURE_DELAY = 3'd2;
localparam STATE_COUNTING = 3'd3;
localparam STATE_NOTIFY_DONE = 3'd4;

reg [2:0] state;
reg [3:0] shift_reg;
reg [11:0] timer;
reg [3:0] delay;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_IDLE;
        counting <= 0;
        done <= 0;
        shift_reg <= 4'b0;
        delay <= 4'b0;
        timer <= 12'b0;
    end else begin
        case (state)
            STATE_IDLE: begin
                if (shift_reg == 4'b1101) begin
                    state <= STATE_CAPTURE_DELAY;
                    shift_reg <= 4'b0;
                end else begin
                    shift_reg <= {shift_reg[2:0], data};
                end
            end
            STATE_CAPTURE_DELAY: begin
                if (shift_reg != 4'b0) begin
                    shift_reg <= {shift_reg[2:0], data};
                    delay <= shift_reg[3:0];
                    state <= STATE_COUNTING;
                    counting <= 1;
                end
            end
            STATE_COUNTING: begin
                timer <= timer + 1;
                if (timer == {delay, 8'b0}) begin
                    state <= STATE_NOTIFY_DONE;
                    counting <= 0;
                    done <= 1;
                end
            end
            STATE_NOTIFY_DONE: begin
                if (ack) begin
                    state <= STATE_IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = (state == STATE_COUNTING) ? (delay - timer[11:8]) : 4'bxxxx;

endmodule

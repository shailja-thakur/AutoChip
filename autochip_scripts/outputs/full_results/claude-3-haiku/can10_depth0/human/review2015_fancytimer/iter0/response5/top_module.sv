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
reg [3:0] timer_count;
reg [3:0] state;
reg [3:0] shift_reg;

localparam IDLE = 0,
           DETECT_START = 1,
           CAPTURE_DELAY = 2,
           COUNT_DOWN = 3,
           NOTIFY_DONE = 4;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
        shift_reg <= 0;
        delay <= 0;
        timer_count <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (shift_reg == 4'b1101) begin
                    state <= CAPTURE_DELAY;
                    shift_reg <= 0;
                end else begin
                    shift_reg <= {shift_reg[2:0], data};
                end
            end
            CAPTURE_DELAY: begin
                if (shift_reg[3:0] != 4'b0000) begin
                    delay <= shift_reg[3:0];
                    state <= COUNT_DOWN;
                    counting <= 1;
                    timer_count <= 0;
                end
            end
            COUNT_DOWN: begin
                if (timer_count == delay) begin
                    state <= NOTIFY_DONE;
                    counting <= 0;
                    done <= 1;
                end else begin
                    timer_count <= timer_count + 1;
                end
            end
            NOTIFY_DONE: begin
                if (ack) begin
                    state <= IDLE;
                    done <= 0;
                end
            end
            default: state <= IDLE;
        endcase
    end
end

assign count = (state == COUNT_DOWN) ? delay - timer_count : 0;

endmodule

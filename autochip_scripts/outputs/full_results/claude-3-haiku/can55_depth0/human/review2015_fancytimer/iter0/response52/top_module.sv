module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam IDLE = 3'd0;
localparam START_DETECT = 3'd1;
localparam SHIFT_DELAY = 3'd2;
localparam COUNTING = 3'd3;
localparam DONE = 3'd4;

reg [2:0] state;
reg [3:0] shift_reg;
reg [13:0] timer;
reg [3:0] delay;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
        shift_reg <= 0;
        timer <= 0;
        delay <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    shift_reg <= {shift_reg[2:0], data};
                    if (shift_reg == 4'b1101) begin
                        state <= START_DETECT;
                    end
                end
            end
            START_DETECT: begin
                if (data == 1'b1) begin
                    shift_reg <= {shift_reg[2:0], data};
                end
                else begin
                    state <= SHIFT_DELAY;
                end
            end
            SHIFT_DELAY: begin
                if (data == 1'b1) begin
                    shift_reg <= {shift_reg[2:0], data};
                    delay <= shift_reg;
                    timer <= 0;
                    state <= COUNTING;
                    counting <= 1;
                end
            end
            COUNTING: begin
                timer <= timer + 1;
                if (timer == (delay + 1) * 14'd1000 - 1) begin
                    state <= DONE;
                    counting <= 0;
                    done <= 1;
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

assign count = (state == COUNTING) ? delay - (timer / 1000) : 'bx;

endmodule

module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

reg [3:0] state, next_state;
reg [3:0] shift_reg;
reg [3:0] delay;
reg [11:0] timer;

localparam [3:0] IDLE = 4'b0000,
                 DETECT = 4'b0001,
                 SHIFT = 4'b0010,
                 COUNT = 4'b0011,
                 NOTIFY = 4'b0100;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        shift_reg <= 4'b0000;
        delay <= 4'b0000;
        timer <= 12'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end else begin
        state <= next_state;

        case (state)
            IDLE: begin
                if (shift_reg == 4'b1101) begin
                    next_state <= SHIFT;
                    shift_reg <= 4'b0000;
                end else begin
                    shift_reg <= {shift_reg[2:0], data};
                    next_state <= IDLE;
                end
            end
            SHIFT: begin
                if (timer < 4'b1000) begin
                    shift_reg <= {data, shift_reg[3:1]};
                    delay <= shift_reg;
                    next_state <= COUNT;
                    timer <= 12'b0;
                    counting <= 1'b1;
                end else begin
                    next_state <= IDLE;
                end
            end
            COUNT: begin
                if (timer < (delay + 1) * 12'd1000 - 1) begin
                    timer <= timer + 12'd1;
                    next_state <= COUNT;
                    counting <= 1'b1;
                end else begin
                    next_state <= NOTIFY;
                    counting <= 1'b0;
                    done <= 1'b1;
                end
            end
            NOTIFY: begin
                if (ack) begin
                    next_state <= IDLE;
                    done <= 1'b0;
                end else begin
                    next_state <= NOTIFY;
                end
            end
            default: begin
                next_state <= IDLE;
            end
        endcase
    end
end

assign count = (state == COUNT) ? delay - (timer / 12'd1000) : 4'bxxxx;

endmodule

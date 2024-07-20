module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam IDLE = 3'b000, START = 3'b001, LOAD_DELAY = 3'b010, COUNTDOWN = 3'b011, NOTIFY = 3'b100;

reg [2:0] state;
reg [3:0] shift_reg;
reg [11:0] timer;
reg [3:0] delay;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
        shift_reg <= 0;
        timer <= 0;
        delay <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (shift_reg[3:0] == 4'b1101) begin
                    state <= START;
                    shift_reg <= 0;
                end else begin
                    shift_reg <= {shift_reg[2:0], data};
                end
                counting <= 0;
                done <= 0;
            end
            START: begin
                shift_reg <= {shift_reg[2:0], data};
                if (shift_reg[7:4] != 0) begin
                    state <= LOAD_DELAY;
                    delay <= shift_reg[7:4];
                    timer <= 0;
                end
            end
            LOAD_DELAY: begin
                state <= COUNTDOWN;
                counting <= 1;
            end
            COUNTDOWN: begin
                timer <= timer + 1;
                if (timer == (delay + 1) * 1000 - 1) begin
                    state <= NOTIFY;
                    counting <= 0;
                    done <= 1;
                end
            end
            NOTIFY: begin
                if (ack) begin
                    state <= IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = (state == COUNTDOWN) ? delay - (timer / 1000) : 0;

endmodule

module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam WAIT_START = 0, WAIT_DURATION = 1, COUNT = 2, WAIT_ACK = 3;
reg [1:0] state;
reg [3:0] shift_reg;
reg [11:0] timer;
reg [3:0] delay;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        shift_reg <= 0;
        timer <= 0;
        delay <= 0;
        counting <= 0;
        done <= 0;
    end else begin
        case (state)
            WAIT_START: begin
                if (shift_reg[3:0] == 4'b1101) begin
                    state <= WAIT_DURATION;
                    shift_reg <= 0;
                end else begin
                    shift_reg <= {shift_reg[2:0], data};
                end
            end
            WAIT_DURATION: begin
                if (shift_reg[3:0] != 4'b0000) begin
                    shift_reg <= {shift_reg[2:0], data};
                end else begin
                    delay <= shift_reg[3:0];
                    state <= COUNT;
                    timer <= 0;
                    counting <= 1;
                end
            end
            COUNT: begin
                if (timer == (delay + 1) * 1000 - 1) begin
                    state <= WAIT_ACK;
                    counting <= 0;
                    done <= 1;
                end else begin
                    timer <= timer + 1;
                end
            end
            WAIT_ACK: begin
                if (ack) begin
                    state <= WAIT_START;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = (state == COUNT) ? delay - (timer / 1000) : 4'bxxxx;

endmodule

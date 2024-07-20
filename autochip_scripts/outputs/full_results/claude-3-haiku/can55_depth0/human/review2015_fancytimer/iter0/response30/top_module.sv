module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam WAIT_START = 0, SHIFT_IN = 1, COUNTING = 2, WAIT_ACK = 3;
reg [1:0] state;
reg [3:0] shift_reg;
reg [13:0] timer;
reg [3:0] delay;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        counting <= 0;
        done <= 0;
        shift_reg <= 0;
        timer <= 0;
        delay <= 0;
    end else begin
        case (state)
            WAIT_START: begin
                if (shift_reg[3:0] == 4'b1101) begin
                    state <= SHIFT_IN;
                    shift_reg <= 0;
                end else begin
                    shift_reg <= {shift_reg[2:0], data};
                end
                counting <= 0;
                done <= 0;
            end
            SHIFT_IN: begin
                shift_reg <= {shift_reg[2:0], data};
                if (shift_reg[3:0] == 4'b0000) begin
                    delay <= shift_reg[7:4];
                    state <= COUNTING;
                    timer <= 0;
                    counting <= 1;
                end
            end
            COUNTING: begin
                timer <= timer + 1;
                if (timer == (delay + 1) * 1000 - 1) begin
                    state <= WAIT_ACK;
                    counting <= 0;
                    done <= 1;
                end
            end
            WAIT_ACK: begin
                if (ack) begin
                    state <= WAIT_START;
                end
            end
        endcase
    end
end

assign count = (state == COUNTING) ? delay - (timer / 1000) : 'bx;

endmodule

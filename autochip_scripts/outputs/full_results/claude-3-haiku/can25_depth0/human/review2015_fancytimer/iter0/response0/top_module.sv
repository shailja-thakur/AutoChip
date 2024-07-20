module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam IDLE = 2'b00, WAIT_DATA = 2'b01, COUNTING = 2'b10, DONE = 2'b11;
reg [1:0] state;
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
                if (shift_reg == 4'b1101) begin
                    state <= WAIT_DATA;
                    shift_reg <= 0;
                end else begin
                    shift_reg <= {shift_reg[2:0], data};
                end
                counting <= 0;
                done <= 0;
            end
            WAIT_DATA: begin
                shift_reg <= {shift_reg[2:0], data};
                if (shift_reg[3:0] == 4'b0000) begin
                    delay <= 0;
                    state <= COUNTING;
                    timer <= 0;
                end else begin
                    delay <= shift_reg[3:0];
                    state <= COUNTING;
                    timer <= 0;
                end
                counting <= 0;
                done <= 0;
            end
            COUNTING: begin
                if (timer < (delay + 1) * 1000 - 1) begin
                    timer <= timer + 1;
                    counting <= 1;
                    done <= 0;
                end else begin
                    state <= DONE;
                    counting <= 0;
                    done <= 1;
                end
            end
            DONE: begin
                if (ack) begin
                    state <= IDLE;
                end
                counting <= 0;
                done <= 1;
            end
        endcase
    end
end

assign count = delay - (timer / 1000);

endmodule

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
reg [3:0] shift_reg;
reg [1:0] state;

localparam SEARCH = 2'b00;
localparam CAPTURE = 2'b01;
localparam DELAY = 2'b10;
localparam DONE = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= SEARCH;
        counting <= 0;
        done <= 0;
        shift_reg <= 0;
        delay <= 0;
        timer_count <= 0;
    end
    else begin
        case (state)
            SEARCH: begin
                if (shift_reg[3:0] == 4'b1101) begin
                    state <= CAPTURE;
                    shift_reg <= 0;
                end
                else begin
                    shift_reg <= {shift_reg[2:0], data};
                end
            end
            CAPTURE: begin
                if (shift_reg[3:0] != 4'b1101) begin
                    shift_reg <= {shift_reg[2:0], data};
                    delay <= shift_reg[3:0];
                    state <= DELAY;
                    counting <= 1;
                    timer_count <= 0;
                end
            end
            DELAY: begin
                if (timer_count == (delay + 1) * 1000 - 1) begin
                    counting <= 0;
                    done <= 1;
                    state <= DONE;
                end
                else begin
                    timer_count <= timer_count + 1;
                end
            end
            DONE: begin
                if (ack) begin
                    done <= 0;
                    state <= SEARCH;
                end
            end
        endcase
    end
end

assign count = (state == DELAY) ? delay - timer_count / 1000 : 4'bxxxx;

endmodule

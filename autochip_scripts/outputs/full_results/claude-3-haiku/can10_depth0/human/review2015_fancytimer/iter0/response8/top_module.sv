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
reg [3:0] counter;
reg [3:0] state;
reg [3:0] shift_reg;

parameter IDLE = 4'b0000;
parameter DETECT = 4'b0001;
parameter SHIFT = 4'b0010;
parameter COUNT = 4'b0011;
parameter WAIT = 4'b0100;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
        shift_reg <= 0;
        delay <= 0;
        counter <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (shift_reg[3:0] == 4'b1101) begin
                    state <= SHIFT;
                    shift_reg <= 0;
                end else begin
                    shift_reg <= {shift_reg[2:0], data};
                end
            end
            SHIFT: begin
                if (counter < 4) begin
                    shift_reg <= {shift_reg[2:0], data};
                    counter <= counter + 1;
                end else begin
                    delay <= shift_reg[3:0];
                    state <= COUNT;
                    counter <= 0;
                    counting <= 1;
                end
            end
            COUNT: begin
                if (counter < (delay + 1) * 1000 - 1) begin
                    counter <= counter + 1;
                end else begin
                    state <= WAIT;
                    counting <= 0;
                    done <= 1;
                    counter <= 0;
                end
            end
            WAIT: begin
                if (ack) begin
                    state <= IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = (state == COUNT) ? (delay - (counter / 1000)) : 4'bxxxx;

endmodule

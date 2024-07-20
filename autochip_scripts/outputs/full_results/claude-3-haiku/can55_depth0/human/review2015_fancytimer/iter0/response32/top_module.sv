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
    reg [3:0] shift_reg;
    reg [1:0] state;

    parameter IDLE = 2'b00;
    parameter DETECT = 2'b01;
    parameter COUNT = 2'b10;
    parameter WAIT_ACK = 2'b11;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            counting <= 0;
            done <= 0;
            shift_reg <= 0;
            delay <= 0;
            counter <= 0;
        end
        else begin
            case (state)
                IDLE: begin
                    if (shift_reg[3:0] == 4'b1101) begin
                        state <= DETECT;
                        shift_reg <= 0;
                    end
                    else begin
                        shift_reg <= {shift_reg[2:0], data};
                    end
                end
                DETECT: begin
                    if (counter < 4) begin
                        shift_reg <= {shift_reg[2:0], data};
                        counter <= counter + 1;
                    end
                    else begin
                        delay <= shift_reg[3:0];
                        counter <= 0;
                        state <= COUNT;
                        counting <= 1;
                    end
                end
                COUNT: begin
                    if (counter < (delay + 1) * 250) begin
                        counter <= counter + 1;
                    end
                    else begin
                        counter <= 0;
                        counting <= 0;
                        state <= WAIT_ACK;
                        done <= 1;
                    end
                end
                WAIT_ACK: begin
                    if (ack) begin
                        state <= IDLE;
                        done <= 0;
                    end
                end
            endcase
        end
    end

    assign count = (state == COUNT) ? delay - (counter / 250) : 0;

endmodule

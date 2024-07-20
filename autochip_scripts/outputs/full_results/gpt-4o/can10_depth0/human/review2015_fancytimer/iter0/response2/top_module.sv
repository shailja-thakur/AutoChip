module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack);

    reg [3:0] state = 0;
    reg [3:0] delay = 0;
    reg [15:0] counter = 0;

    localparam IDLE = 4'b0000,
               DETECT1 = 4'b0001,
               DETECT2 = 4'b0010,
               DETECT3 = 4'b0011,
               DETECT4 = 4'b0100,
               LOAD1 = 4'b0101,
               LOAD2 = 4'b0110,
               LOAD3 = 4'b0111,
               LOAD4 = 4'b1000,
               COUNT = 4'b1001,
               DONE = 4'b1010;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            count <= 4'd0;
            counting <= 1'b0;
            done <= 1'b0;
            delay <= 4'd0;
            counter <= 16'd0;
        end else begin
            case (state)
                IDLE: begin
                    count <= 4'd0;
                    counting <= 1'b0;
                    done <= 1'b0;
                    if (data) 
                        state <= DETECT1;
                end
                DETECT1: begin
                    if (~data) 
                        state <= DETECT2;
                    else 
                        state <= IDLE;
                end
                DETECT2: begin
                    if (data) 
                        state <= DETECT3;
                    else 
                        state <= IDLE;
                end
                DETECT3: begin
                    if (data) 
                        state <= DETECT4;
                    else 
                        state <= IDLE;
                end
                DETECT4: begin
                    if (~data) 
                        state <= LOAD1;
                    else 
                        state <= IDLE;
                end
                LOAD1: begin
                    delay[3] <= data;
                    state <= LOAD2;
                end
                LOAD2: begin
                    delay[2] <= data;
                    state <= LOAD3;
                end
                LOAD3: begin
                    delay[1] <= data;
                    state <= LOAD4;
                end
                LOAD4: begin
                    delay[0] <= data;
                    state <= COUNT;
                    counting <= 1'b1;
                    counter <= (delay + 1) * 1000;
                end
                COUNT: begin
                    if (counter > 0) begin
                        counter <= counter - 1;
                        count <= counter / 1000;
                    end else begin
                        counting <= 1'b0;
                        done <= 1'b1;
                        state <= DONE;
                    end
                end
                DONE: begin
                    if (ack) begin
                        done <= 1'b0;
                        state <= IDLE;
                    end
                end
                default: state <= IDLE;
            endcase
        end
    end
endmodule

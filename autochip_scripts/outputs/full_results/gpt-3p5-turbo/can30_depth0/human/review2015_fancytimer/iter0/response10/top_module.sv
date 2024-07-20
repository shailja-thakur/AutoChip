module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [1:0] state;
    reg [11:0] counter;
    reg [1:0] count_remaining;
    reg [1:0] delay_remaining;
    
    parameter IDLE = 2'b00;
    parameter START = 2'b01;
    parameter COUNT = 2'b10;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            count_remaining <= 2'b00;
            delay_remaining <= 2'b00;
            counter <= 12'b000000000000;
            counting <= 0;
            done <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (data == 4'b1101) begin
                        state <= START;
                        count_remaining <= delay;
                        delay_remaining <= delay;
                    end
                end
                START: begin                   
                    state <= COUNT;
                    counter <= 12'b000000000000;
                    counting <= 1;
                end
                COUNT: begin
                    if (counter == (count_remaining + 1)*1000 - 1) begin
                        counting <= 0;
                        done <= 1;
                    end
                    
                    counter <= counter + 1;
                    
                    if (counter % 1000 == 0 && counter > 0) begin
                        delay_remaining <= delay_remaining - 1;
                        count_remaining <= count_remaining - 1;
                    end
                    
                    if (counter % 1000 == 0) begin
                        count <= count_remaining;
                    end else begin
                        count <= delay_remaining;
                    end
                end
            endcase
        end
    end
    
    always @(posedge clk) begin
        if (done && ack) begin
            state <= IDLE;
            count_remaining <= 2'b00;
            delay_remaining <= 2'b00;
            counter <= 12'b000000000000;
            counting <= 0;
            done <= 0;
        end
    end
    
endmodule

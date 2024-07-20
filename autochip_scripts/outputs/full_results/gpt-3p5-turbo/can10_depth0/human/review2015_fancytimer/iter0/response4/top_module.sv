module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );
    
    reg [3:0] delay;
    reg [2:0] state;
    reg [2:0] next_state;
    reg [9:0] counter;
    reg [3:0] remaining_time;
    reg start_detected;
    
    parameter START = 0;
    parameter SHIFT_IN_DELAY = 1;
    parameter COUNTING = 2;
    parameter WAIT_FOR_ACK = 3;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= START;
            counting <= 0;
            done <= 0;
            counter <= 0;
            remaining_time <= 0;
            start_detected <= 0;
        end else begin
            state <= next_state;
            counting <= (state == COUNTING);
        end
    end
    
    always @(posedge clk) begin
        case (state)
            START: begin
                if (data == 4'b1101) begin
                    start_detected <= 1;
                    next_state <= SHIFT_IN_DELAY;
                end else begin
                    start_detected <= 0;
                    next_state <= START;
                end
            end
            SHIFT_IN_DELAY: begin
                delay <= data;
                next_state <= COUNTING;
                counter <= (delay + 1) * 1000 - 1;
                remaining_time <= delay;
            end
            COUNTING: begin
                if (counter == 0) begin
                    next_state <= WAIT_FOR_ACK;
                end else begin
                    counter <= counter - 1;
                    if (counter % 1000 == 0) begin
                        remaining_time <= remaining_time - 1;
                    end
                    next_state <= COUNTING;
                end
            end
            WAIT_FOR_ACK: begin
                if (ack == 1) begin
                    next_state <= START;
                    done <= 1;
                end else begin
                    next_state <= WAIT_FOR_ACK;
                end
            end
            default: next_state <= START;
        endcase
    end
    
    assign count = counting ? remaining_time : 4'bxxxx;
    
endmodule

module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] timer;
    reg [3:0] remaining_time;
    reg [3:0] state;
    reg [3:0] next_state;
    reg [3:0] temp;
    reg delay_set;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 4'b0000;
            counting <= 0;
            done <= 0;
            delay <= 0;
            timer <= 0;
            remaining_time <= 0;
            delay_set <= 0;
        end else begin
            state <= next_state;
            counting <= (state == 4'b1111);
            done <= (state == 4'b1110);
            if (delay_set) begin
                delay <= data;
                delay_set <= 0;
            end
            timer <= counting ? timer + 1 : 0;
            remaining_time <= counting ? remaining_time - 1 : delay;
        end
    end
    
    always @(posedge clk) begin
        case(state)
            4'b0000: if (data == 1) next_state <= 4'b0001; else next_state <= state;
            4'b0001: if (data == 1) next_state <= 4'b0010; else next_state <= state;
            4'b0010: if (data == 0) begin
                        next_state <= 4'b0011;
                        delay_set <= 1;
                      end else begin
                        next_state <= state;
                      end
            4'b0011: next_state <= 4'b0100;
            4'b0100: if (timer < (delay + 1) * 1000) next_state <= 4'b0100; else next_state <= 4'b0101;
            4'b0101: next_state <= 4'b0110;
            4'b0110: if (ack == 1) next_state <= 4'b0000; else next_state <= state;
            default: next_state <= 4'b0000;
        endcase
    end
    
    assign count = counting ? remaining_time : 4'bXXXX;
    
endmodule

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
    reg start_sequence;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 4'b0000;
            counting <= 0;
            done <= 0;
            delay <= 0;
            timer <= 0;
            remaining_time <= 0;
            start_sequence <= 0;
        end else begin
            state <= next_state;
            counting <= (state == 4'b1111);
            done <= (state == 4'b1110);
            delay <= (state == 4'b0011) ? data : delay;
            timer <= counting ? timer + 1 : 0;
            remaining_time <= counting ? remaining_time - 1 : delay;
            start_sequence <= (state == 4'b0100) ? 1 : 0;
        end
    end
    
    always @(posedge clk) begin
        case(state)
            4'b0000: if (data == 1) next_state <= 4'b0001; else next_state <= state;
            4'b0001: if (data == 1) next_state <= 4'b0010; else next_state <= state;
            4'b0010: if (data == 0) next_state <= 4'b0011; else next_state <= state;
            4'b0011: next_state <= 4'b0100;
            4'b0100: if (timer < (delay + 1) * 1000) next_state <= 4'b0100; else next_state <= 4'b0101;
            4'b0101: next_state <= 4'b0110;
            4'b0110: if (ack == 1) next_state <= 4'b0000; else next_state <= state;
            default: next_state <= 4'b0000;
        endcase
    end
    
    assign count = counting ? remaining_time : 4'bXXXX;
    
endmodule

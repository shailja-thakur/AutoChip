module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );
    
    reg [3:0] delay;
    reg [3:0] timer;
    reg [3:0] remaining_time;
    reg [3:0] state;
    reg start_sequence_detected;
    
    always @(posedge clk) begin
        if (reset) begin
            start_sequence_detected <= 0;
            counting <= 0;
            done <= 0;
            delay <= 0;
            timer <= 0;
            remaining_time <= 0;
            count <= 0;
            state <= 0;
        end else begin
            case(state)
                0: begin
                    if (start_sequence_detected == 0 && data == 1 && $past(data, 1) == 1 && $past(data, 2) == 0 && $past(data, 3) == 1) begin
                        start_sequence_detected <= 1;
                        delay <= data;
                        timer <= (delay + 1) * 1000;
                        counting <= 1;
                        state <= 1;
                    end
                end
                1: begin
                    if (timer > 0) begin
                        timer <= timer - 1;
                        count <= remaining_time;
                        remaining_time <= remaining_time - 1;
                    end else begin
                        counting <= 0;
                        done <= 1;
                        state <= 2;
                    end
                end
                2: begin
                    if (ack) begin
                        start_sequence_detected <= 0;
                        counting <= 0;
                        done <= 0;
                        delay <= 0;
                        timer <= 0;
                        remaining_time <= 0;
                        count <= 0;
                        state <= 0;
                    end
                end
            endcase
        end
    end
endmodule

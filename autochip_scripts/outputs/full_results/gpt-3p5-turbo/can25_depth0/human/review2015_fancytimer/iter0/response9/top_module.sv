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
    reg [3:0] remaining_time;
    
    always @(posedge clk) begin
        if (reset) begin
            counting <= 0;
            done <= 0;
            state <= 0;
            counter <= 0;
            delay <= 0;
            remaining_time <= 0;
        end
        else begin
            case (state)
                0: begin // Searching for start sequence (1101)
                    if (data) begin
                        counter <= counter + 1;
                        
                        if (counter >= 3'b110) begin
                            counter <= 0;
                            state <= 1;
                            delay <= (data >> 4);
                        end
                    end
                    else begin
                        counter <= 0;
                    end
                end
                
                1: begin // Counting state
                    counting <= 1;
                    remaining_time <= delay;
                    
                    if (counter < ((delay + 1) * 1000)) begin
                        counter <= counter + 1;
                        
                        if (counter % 1000 == 0) begin
                            remaining_time <= remaining_time - 1;
                        end
                    end
                    else begin
                        counter <= 0;
                        state <= 2;
                        counting <= 0;
                        done <= 1;
                    end
                end
                
                2: begin // Waiting for ack
                    counting <= 0;
                    
                    if (ack) begin
                        done <= 0;
                        state <= 0;
                    end
                end
            endcase
        end
    end
    
    assign count = counting ? remaining_time : 4'bxxxx;    
endmodule

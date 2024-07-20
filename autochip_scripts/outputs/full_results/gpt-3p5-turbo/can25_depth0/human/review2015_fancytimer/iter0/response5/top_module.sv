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
    reg [3:0] count_reg;
    reg searching;
    reg [2:0] delay_count;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            delay <= 0;
            counting <= 0;
            done <= 0;
            count_reg <= 0;
            searching <= 1;
            delay_count <= 0;
        end else begin
            case (state)
                0: begin
                    if (data) begin
                        state <= 1;
                        searching <= 0;
                    end
                end
                1: begin
                    if (data) begin
                        state <= 2;
                        delay <= data;
                    end else begin
                        state <= 0;
                        searching <= 1;
                    end
                end
                2: begin
                    if (data) begin
                        state <= 3;
                        delay <= delay + data;
                    end else begin
                        state <= 0;
                        searching <= 1;
                    end
                end
                3: begin
                    if (data) begin
                        state <= 4;
                        counting <= 1;
                        count_reg <= delay;
                        delay_count <= delay + 1;
                    end else begin
                        state <= 0;
                        searching <= 1;
                    end
                end
                4: begin
                    if (delay_count != 0) begin
                        delay_count <= delay_count - 1;
                    end else begin
                        state <= 5;
                    end
                end
                5: begin
                    if (delay != 0) begin
                        delay <= delay - 1;
                        delay_count <= delay + 1;
                        state <= 4;
                    end else begin
                        state <= 6;
                        counting <= 0;
                        done <= 1;
                    end
                end
                6: begin
                    if (ack) begin
                        state <= 0;
                        done <= 0;
                        count_reg <= 0;
                        searching <= 1;
                    end
                end
            endcase
        end
    end
    
    always @(posedge clk) begin
        if (counting) begin
            count_reg <= count_reg - 1;
        end
    end
    
    assign count = count_reg;
    
endmodule

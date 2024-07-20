module top_module (
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );
    
    reg [3:0] delay;
    reg [1:0] state;
    reg [9:0] counter;
    reg [3:0] remaining_time;
    reg [3:0] shift_reg;
    wire enable;
    
    assign enable = (state == 2) ? 1'b1 : 1'b0;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 2'b00;
            counter <= 10'b0;
            shift_reg <= 4'b0;
            counting <= 1'b0;
            done <= 1'b0;
            remaining_time <= 4'b0;
        end else begin
            case (state)
                2'b00: begin
                    shift_reg <= {shift_reg[2:0], data};
                    if (shift_reg == 4'b1101) begin
                        delay <= {data, shift_reg[3:1]};
                        state <= 2'b01;
                    end
                end
                2'b01: begin
                    counting <= 1'b1;
                    state <= 2'b10;
                    remaining_time <= delay;
                    counter <= 10'b0;
                end
                2'b10: begin
                    counter <= counter + 10'b1;
                    if (counter >= (delay + 1) * 10'd1000) begin
                        counting <= 1'b0;
                        done <= 1'b1;
                        
                        if (ack) begin
                            state <= 2'b00;
                        end
                    end else begin
                        if (counter % 10'd1000 == 0) begin
                            remaining_time <= remaining_time - 1'b1;
                        end
                    end
                end
            endcase
        end
    end
    
    assign count = counting ? remaining_time : 4'bxxxx;
    
endmodule

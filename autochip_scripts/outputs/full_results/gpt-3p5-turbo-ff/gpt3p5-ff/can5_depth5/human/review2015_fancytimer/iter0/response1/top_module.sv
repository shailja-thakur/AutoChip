module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );
    
    reg [3:0] delay;
    reg [3:0] remaining_time;
    reg [3:0] shift;
    reg [1:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00;
            count <= 4'b0;
            counting <= 0;
            done <= 0;
            remaining_time <= 4'b0;
            shift <= 4'b0;
        end else begin
            case (state)
                2'b00:
                    if (data == 1'b1) begin
                        state <= 2'b01;
                        shift <= 4'b0;
                    end
                    
                2'b01:
                    if (data == 1'b1) begin
                        shift <= {shift[2:0], data};
                        
                        if (shift == 4'b1101) begin
                            state <= 2'b10;
                            delay <= shift[3:0];
                            shift <= 4'b0;
                            counting <= 1;
                            remaining_time <= delay;
                        end
                    end else begin
                        state <= 2'b00;
                    end
                    
                2'b10:
                    if (counting && remaining_time > 4'b0) begin
                        remaining_time <= remaining_time - 1;
                    end else begin
                        counting <= 0;
                        done <= 1;
                        if (ack == 1'b1) begin
                            state <= 2'b00;
                            done <= 0;
                        end
                    end
                    
                default:
                    state <= 2'b00;
            endcase
            
            if (counting) begin
                count <= remaining_time;
            end
        end
    end
    
endmodule

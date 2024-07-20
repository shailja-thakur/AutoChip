module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [1:0] state;
    
    always @(posedge clk) begin
        if (reset)
            state <= 2'b00;
        else begin
            case (state)
                2'b00: begin
                    if (data == 4'b1101) begin
                        count <= data[3:0];
                        delay <= data[3:0];
                        counting <= 1'b1;
                        state <= 2'b01;
                    end
                end
                2'b01: begin
                    if (count == 4'b0000) begin
                        counting <= 1'b0;
                        done <= 1'b1;
                        state <= 2'b10;
                    end else if (ack) begin
                        counting <= 1'b0;
                        count <= delay;
                        state <= 2'b00;
                    end else
                        count <= count - 1;
                end
                2'b10: begin
                    if (ack) begin
                        done <= 1'b0;
                        state <= 2'b00;
                    end
                end
                default: state <= 2'b00;
            endcase
        end
    end

endmodule

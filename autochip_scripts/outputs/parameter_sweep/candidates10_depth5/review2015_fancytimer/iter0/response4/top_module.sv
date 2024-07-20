module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] state;
    reg [3:0] count_reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 4'b0000;
            counting <= 0;
            done <= 0;
            count_reg <= 4'b0000;
        end else begin
            case (state)
                4'b0000:
                    if (data == 1'b1) begin
                        state <= 4'b0001;
                    end else begin
                        state <= 4'b0000;
                    end
                4'b0001:
                    if (data == 1'b1) begin
                        state <= 4'b0001;
                    end else begin
                        state <= 4'b0010;
                        delay <= data;
                    end
                4'b0010:
                    if (count_reg < (delay + 1)) begin
                        state <= 4'b0010;
                        counting <= 1;
                    end else begin
                        state <= 4'b0011;
                        counting <= 0;
                    end
                4'b0011:
                    if (ack == 1'b1) begin
                        state <= 4'b0000;
                        done <= 1;
                    end else begin
                        state <= 4'b0011;
                        done <= 0;
                    end
            endcase
            
            if (state == 4'b0010 && count_reg < (delay + 1) && counting) begin
                count_reg <= count_reg + 1;
            end else if (state == 4'b0010 && counting) begin
                count_reg <= 4'b0000;
            end else begin
                count_reg <= count_reg;
            end
        end
    end

    assign count = count_reg;

endmodule

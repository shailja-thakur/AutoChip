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

always @(posedge clk) begin
    if (reset) begin
        state <= 0;
        counting <= 0;
        done <= 0;
        count_reg <= 0;
    end else begin
        case (state)
            0: begin
                if (data == 1) begin
                    state <= 1;
                end
            end
            1: begin
                if (data == 1) begin
                    state <= 2;
                end else begin
                    state <= 0;
                end
            end
            2: begin
                if (data == 0) begin
                    state <= 3;
                end else begin
                    state <= 0;
                end
            end
            3: begin
                if (data == 1) begin
                    state <= 4;
                end else begin
                    state <= 0;
                end
            end
            4: begin
                count_reg <= data;
                state <= 5;
            end
            5: begin
                counting <= 1;
                state <= 6;
                count_reg <= count_reg - 1;
                count <= count_reg;
            end
            6: begin
                counting <= 1;
                count_reg <= count_reg - 1;
                count <= count_reg;
                if (count_reg == 0) begin
                    state <= 7;
                    done <= 1;
                end
            end
            7: begin
                if (ack == 1) begin
                    state <= 0;
                    done <= 0;
                    counting <= 0;
                end
            end
            default: state <= 0;
        endcase
    end
end

endmodule

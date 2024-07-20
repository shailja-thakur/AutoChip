module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

reg [3:0] delay;
reg [3:0] count_reg;
reg [2:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        counting <= 0;
        done <= 0;
        count_reg <= 0;
    end else begin
        case(state)
            0: begin // Searching for start sequence
                if (data == 4'b1101) begin
                    delay <= data[3:0];
                    state <= 1;
                    counting <= 1;
                end
            end
            1: begin // Counting
                counting <= 1;
                if (count_reg == delay) begin
                    if (count_reg == 0) begin
                        done <= 1;
                        counting <= 0;
                        state <= 2;
                    end else begin
                        count_reg <= count_reg - 1;
                    end
                else begin
                    count_reg <= delay;
                end
            end
            2: begin // Waiting for ack
                if (ack) begin
                    done <= 0;
                    state <= 0;
                end
            end
        endcase
    end
end

assign count = (state == 1) ? count_reg : 4'bxxxx;

endmodule

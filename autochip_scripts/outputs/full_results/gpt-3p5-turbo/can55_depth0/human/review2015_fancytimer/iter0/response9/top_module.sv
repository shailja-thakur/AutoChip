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
        state <= 2'b0;
    else begin
        case(state)
            2'b00: begin
                if (data == 4'b1101) begin
                    state <= 2'b01;
                    delay <= data;
                    counting <= 1'b1;
                end
                else
                    state <= 2'b00;
            end
            2'b01: begin
                state <= 2'b10;
            end
            2'b10: begin
                if (count < (delay + 1))
                    count <= count + 1;
                else begin
                    state <= 2'b11;
                    done <= 1'b1;
                    counting <= 1'b0;
                end
            end
            2'b11: begin
                if (ack) begin
                    state <= 2'b00;
                    delay <= 4'b0;
                    count <= 4'b0;
                    done <= 1'b0;
                end
                else
                    state <= 2'b11;
            end
            default: state <= 2'b00;
        endcase
    end
end

endmodule

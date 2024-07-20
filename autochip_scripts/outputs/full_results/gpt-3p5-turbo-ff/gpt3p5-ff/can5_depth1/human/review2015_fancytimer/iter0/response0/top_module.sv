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

always @(posedge clk) begin
    if (reset) begin
        state <= 3'b000;
        counting <= 1'b0;
        done <= 1'b0;
        delay <= 4'b0000;
    end else begin
        case (state)
            3'b000:
                if (data == 1'b1)
                    state <= 3'b001;
                else
                    state <= 3'b000;
            3'b001:
                if (data == 1'b1)
                    state <= 3'b010;
                else
                    state <= 3'b000;
            3'b010:
                if (data == 1'b0)
                    state <= 3'b011;
                else
                    state <= 3'b000;
            3'b011:
                if (data == 1'b1) begin
                    state <= 3'b100;
                    delay <= {delay[2:0], data};
                end else begin
                    state <= 3'b000;
                    delay <= 4'b0000;
                end
            3'b100:
                begin
                    counting <= 1'b1;
                    state <= 3'b101;
                end
            3'b101:
                begin
                    if (count == {(delay + 1) * 1000 - 1, 1'b0}) begin
                        counting <= 1'b0;
                        done <= 1'b1;
                        state <= 3'b110;
                    end
                end
            3'b110:
                begin
                    if (ack) begin
                        counting <= 1'b0;
                        done <= 1'b0;
                        state <= 3'b000;
                    end
                end
        endcase
    end
end

assign count = counting ? delay : 4'bxxxx;

endmodule

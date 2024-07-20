module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

reg [2:0] Y;

always @(posedge clk) begin
    case ({x, y})
        2'b00_0: begin
            Y <= 3'b00_0;
            z <= 1'b0;
        end
        2'b00_1: begin
            Y <= 3'b00_1;
            z <= 1'b0;
        end
        2'b01_0: begin
            Y <= 3'b01_0;
            z <= 1'b0;
        end
        2'b01_1: begin
            Y <= 3'b01_0;
            z <= 1'b1;
        end
        2'b10_0: begin
            Y <= 3'b11_0;
            z <= 1'b1;
        end
        default: begin
            Y <= 3'b00_0;
            z <= 1'b0;
        end
    endcase
end

assign Y0 = Y[0];

endmodule

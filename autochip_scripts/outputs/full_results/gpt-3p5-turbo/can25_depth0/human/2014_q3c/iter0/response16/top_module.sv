module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

always @(posedge clk) begin
    case ({x, y})
        2'b00_000: begin
            Y0 <= 1'b0;
            z <= 1'b0;
        end
        2'b01_001, 2'b01_100: begin
            Y0 <= 1'b0;
            z <= 1'b0;
        end
        2'b10_010, 2'b10_001: begin
            Y0 <= 1'b0;
            z <= 1'b0;
        end
        2'b11_001: begin
            Y0 <= 1'b0;
            z <= 1'b1;
        end
        2'b11_010, 2'b11_100: begin
            Y0 <= 1'b1;
            z <= 1'b1;
        end
        default: begin
            Y0 <= 1'b0;
            z <= 1'b0;
        end
    endcase
end

endmodule

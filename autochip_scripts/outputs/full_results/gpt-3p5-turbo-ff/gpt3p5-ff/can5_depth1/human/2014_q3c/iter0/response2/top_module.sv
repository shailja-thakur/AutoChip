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
        2'b00_000: begin
            Y <= 3'b00_000;
            z <= 1'b0;
        end
        2'b01_001,
        2'b10_010: begin
            Y <= 3'b01_001;
            z <= 1'b0;
        end
        2'b01_011: begin
            Y <= 3'b01_010;
            z <= 1'b1;
        end
        2'b10_100: begin
            Y <= 3'b11_100;
            z <= 1'b1;
        end
        default: begin
            Y <= 3'bxx_xxx;
            z <= 1'bx;
        end
    endcase
end

assign Y0 = Y[0];

endmodule

module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

always @(posedge clk) begin
    case ({a,q})
        3'b100: q <= 3'b100;
        3'b000: q <= 3'b100;
        3'b001: q <= 3'b101;
        3'b010: q <= 3'b110;
        3'b011: q <= 3'b110;
        3'b100: q <= 3'b000;
        3'b101: q <= 3'b001;
        3'b110: q <= 3'b001;
        default: q <= 3'b000;
    endcase
end

endmodule

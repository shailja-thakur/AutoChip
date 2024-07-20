module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

always @(posedge clk) begin
    if (a) begin
        case (q)
            3'b000: q <= 3'b100;
            3'b100: q <= q;
            3'b101: q <= 3'b110;
            3'b110: q <= 3'b000;
            default: q <= q;
        endcase
    end
    else begin
        case (q)
            3'b100: q <= 3'b100;
            3'b101: q <= 3'b110;
            3'b110: q <= 3'b000;
            3'b000: q <= 3'b001;
            3'b001: q <= 3'b000;
            default: q <= q;
        endcase
    end
end

endmodule

module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

always @(posedge clk) begin
    case (q)
        3'b000: q <= 3'b100;
        3'b100: begin
            if (a) begin
                q <= q;
            end else begin
                q <= q + 1'b1;
            end
        end
        3'b101: q <= 3'b110;
        3'b110: q <= 3'b000;
        default: q <= 3'b000;
    endcase
end

endmodule

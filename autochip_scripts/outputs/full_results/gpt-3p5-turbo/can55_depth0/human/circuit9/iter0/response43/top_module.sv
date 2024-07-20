module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

always @(posedge clk) begin
    if (a) begin
        case (q)
            3'b000: q <= 3'b100;
            3'b100: q <= 3'b011;
            3'b011: q <= 3'b010;
            default: q <= 3'b001;
        endcase
    end else begin
        q <= 3'b000;
    end
end

endmodule

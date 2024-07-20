module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

always @(posedge clk) begin
    if (a == 1'b1) begin
        case (q)
            3'b000: q <= 3'b100;  // q = 4
            3'b100: q <= 3'b100;  // q = 4
            3'b010: q <= 3'b100;  // q = 4
            3'b110: q <= 3'b100;  // q = 4
            3'b001: q <= 3'b100;  // q = 4
            3'b011: q <= 3'b100;  // q = 4
            default: q <= 3'b000; // q = 0
        endcase
    end else begin
        q <= 3'b000; // q = 0
    end
end

endmodule

module top_module(
    input clk,
    input a, 
    output reg [2:0] q
);

always @(posedge clk) begin
    if (a) begin
        case (q)
            0: q <= 4;
            4: q <= 4;
            5: q <= 5;
            6: q <= 6;
            default: q <= 0;
        endcase
    end else begin
        q <= 0;
    end
end

endmodule

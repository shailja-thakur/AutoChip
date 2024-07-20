module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

always @(posedge clk) begin
    case(q)
        0: if(a) q <= 4;
        4: if(~a) q <= 5;
        5: if(a) q <= 6;
        6: if(~a) q <= 0;
        default: q <= q;
    endcase
end

endmodule

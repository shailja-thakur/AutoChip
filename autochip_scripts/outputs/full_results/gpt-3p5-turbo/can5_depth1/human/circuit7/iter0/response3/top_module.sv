module top_module (
    input clk,
    input a,
    output reg q
);
    always @(posedge clk) begin
        case(q)
            1: q <= 0;
            0: q <= a;
        endcase
    end
endmodule

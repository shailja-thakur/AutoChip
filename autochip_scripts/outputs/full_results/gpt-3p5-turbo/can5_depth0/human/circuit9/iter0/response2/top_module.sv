module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);
    always @(posedge clk) begin
        case({a, q})
            2'b01: q <= 4;
            2'b10: q <= q + 1;
            2'b11: q <= 0;
            default: q <= q;
        endcase
    end
endmodule

module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);

always @(*) begin
    case({a, b, c, d, e})
        5'd0: q = b;
        5'd1: q = e;
        5'd2: q = a;
        5'd3: q = d;
        5'd4: q = 4'b1111;
        5'd5: q = 4'b1111;
        5'd6: q = 4'b1111;
        5'd7: q = 4'b1111;
        5'd8: q = 4'b1111;
        5'd9: q = 4'b1111;
        5'd10: q = 4'b1111;
        5'd11: q = 4'b1111;
        5'd12: q = 4'b1111;
        5'd13: q = 4'b1111;
        5'd14: q = 4'b1111;
        5'd15: q = 4'b1111;
        default: q = 4'b1111;
    endcase
end

endmodule

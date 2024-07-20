module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

always @(*)
begin
    case({a,b,c,d})

        4'd0:
            out = 1'b0;
        4'd1:
            out = 1'b0;
        4'd3:
            out = 1'b1;
        4'd2:
            out = 1'b1;
        4'd4:
            out = 1'bx;
        4'd5:
            out = 1'b0;
        4'd7:
            out = 1'b0;
        4'd6:
            out = 1'b0;
        4'd12:
            out = 1'b1;
        4'd13:
            out = 1'bx;
        4'd15:
            out = 1'b1;
        4'd14:
            out = 1'b1;
        4'd8:
            out = 1'b1;
        4'd9:
            out = 1'bx;
        4'd11:
            out = 1'b1;
        4'd10:
            out = 1'b1;

    endcase
end

endmodule

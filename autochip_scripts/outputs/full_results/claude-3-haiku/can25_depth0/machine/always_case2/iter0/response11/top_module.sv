module top_module (
    input [3:0] in,
    output reg [1:0] pos
);

always @(*) begin
    case (in)
        4'd0, 4'd1, 4'd3, 4'd5, 4'd7, 4'd9, 4'd11, 4'd13, 4'd15:
            pos <= 2'd0;
        4'd2, 4'd6, 4'd10, 4'd14:
            pos <= 2'd1;
        4'd4, 4'd12:
            pos <= 2'd2;
        4'd8:
            pos <= 2'd3;
        default:
            pos <= 2'd0;
    endcase
end

endmodule

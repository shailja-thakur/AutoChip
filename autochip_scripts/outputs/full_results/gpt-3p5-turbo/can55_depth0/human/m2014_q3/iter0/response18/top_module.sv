module top_module (
    input [4:1] x,
    output logic f
);

// Define the output f using a case statement for each input combination

always_comb begin
    case (x)
        4'd0: f = 1'b0;
        4'd1: f = 1'bx;
        4'd2: f = 1'bx;
        4'd3: f = 1'b0;
        4'd4: f = 1'b0;
        4'd5: f = 1'bx;
        4'd6: f = 1'b0;
        4'd7: f = 1'b1;
        4'd8: f = 1'b1;
        4'd9: f = 1'b1;
        4'd10: f = 1'bx;
        4'd11: f = 1'bx;
        4'd12: f = 1'bx;
        4'd13: f = 1'b0;
        4'd14: f = 1'bx;
        4'd15: f = 1'bx;
    endcase
end

endmodule

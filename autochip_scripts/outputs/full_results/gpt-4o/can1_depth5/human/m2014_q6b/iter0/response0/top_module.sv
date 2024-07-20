module top_module(
	input [3:1] y,
	input w,
	output reg Y2);

    // State encoding
    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter C = 3'b010;
    parameter D = 3'b011;
    parameter E = 3'b100;
    parameter F = 3'b101;
    
    always @(*) begin
        case (y)
            A: Y2 = 0;
            B: Y2 = (w ? 1 : 0);
            C: Y2 = 1;
            D: Y2 = (w ? 0 : 1);
            E: Y2 = 1;
            F: Y2 = 0;
            default: Y2 = 1'bx;
        endcase
    end
endmodule

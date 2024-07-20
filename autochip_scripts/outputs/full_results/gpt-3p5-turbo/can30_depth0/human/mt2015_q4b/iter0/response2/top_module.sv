module top_module(
	input x,
	input y,
	output z);

    reg z;

    always @(x, y) begin
        case({x, y})
            2'b01: z = 1;
            2'b10: z = 0;
            default: z = 1;
        endcase
    end

endmodule

module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
    always @(*) begin
        case(sel)
            8'b00000000: out = in[3:0];
            8'b00000001: out = in[7:4];
            8'b00000010: out = in[11:8];
            //...
            //Define cases for all possible values of sel
                
            default: out = 4'b0000; // Default case if sel does not match any defined cases
        endcase
    end
endmodule

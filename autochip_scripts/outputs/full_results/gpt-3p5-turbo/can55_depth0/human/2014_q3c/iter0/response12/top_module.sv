module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);
    reg [2:0] next_y;
    
    always @(posedge clk) begin
        case({y, x})
            3'b000: next_y = 3'b000;
            3'b001: next_y = 3'b001;
            3'b010: next_y = 3'b010;
            3'b011: next_y = 3'b001;
            3'b100: next_y = 3'b011;
            default: next_y = 3'b000;
        endcase
        
        Y0 <= next_y[0];
        z <= (next_y == 3'b011) ? 1'b1 : 1'b0;
    end
endmodule

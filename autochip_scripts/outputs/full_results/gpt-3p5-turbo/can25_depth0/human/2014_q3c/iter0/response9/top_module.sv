module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);
    reg [2:0] Y;
    
    always @(posedge clk) begin
        case ({x, y})
            3'b000: begin
                Y <= 3'b000;
                z <= 0;
            end
            3'b001: begin
                if (x)
                    Y <= 3'b100;
                else
                    Y <= 3'b001;
                z <= 0;
            end
            3'b010: begin
                if (x)
                    Y <= 3'b001;
                else
                    Y <= 3'b010;
                z <= 0;
            end
            3'b011: begin
                if (x)
                    Y <= 3'b010;
                else
                    Y <= 3'b001;
                z <= 1;
            end
            3'b100: begin
                if (x)
                    Y <= 3'b100;
                else
                    Y <= 3'b011;
                z <= 1;
            end
            default: begin
                Y <= 3'bxxx;
                z <= 0;
            end
        endcase
    end
    
    assign Y0 = Y[0];
endmodule

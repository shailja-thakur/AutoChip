module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

reg [2:0] Y;
always @(posedge clk) begin
    case ({y, x})
        3'd0: begin
            Y <= 3'd0;
            Y0 <= Y[0];
            z <= 1'b0;
        end
        3'd1: begin
            Y <= 3'd1;
            Y0 <= Y[0];
            z <= 1'b0;
        end
        3'd2: begin
            Y <= 3'd1;
            Y0 <= Y[0];
            z <= 1'b0;
        end
        3'd3: begin
            Y <= 3'd1;
            Y0 <= Y[0];
            z <= 1'b1;
        end
        3'd4: begin
            Y <= 3'd3;
            Y0 <= Y[0];
            z <= 1'b1;
        end
        default: begin
            Y <= 3'd0;
            Y0 <= 1'b0;
            z <= 1'b0;
        end
    endcase
end

endmodule

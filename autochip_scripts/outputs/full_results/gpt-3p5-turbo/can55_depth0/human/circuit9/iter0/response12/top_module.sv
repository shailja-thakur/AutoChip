module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

always @(posedge clk) begin
    if (a == 1'b1) begin
        if (q == 3'b100) begin
            q <= 3'b101;
        end else if (q == 3'b101) begin
            q <= 3'b110;
        end
    end else begin
        if (q == 3'b010) begin
            q <= 3'b100;
        end else if (q == 3'b100) begin
            q <= 3'b010;
        end else if (q == 3'b110) begin
            q <= 3'b000;
        end else if (q == 3'b000) begin
            q <= 3'b001;
        end
    end
end

endmodule

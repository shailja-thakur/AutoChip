module top_module(
	input clk,
	input resetn,
	input [1:0] byteena,
	input [15:0] d,
	output reg [15:0] q);
	
	reg [15:0] q_reg;

	always @(posedge clk or negedge resetn) begin
        if (!resetn)
            q_reg <= 16'b0;
        else begin
            if (byteena[0])
                q_reg[7:0] <= d[7:0];
            if (byteena[1])
                q_reg[15:8] <= d[15:8];
        end
    end
    
    always @*
        q = q_reg;

endmodule

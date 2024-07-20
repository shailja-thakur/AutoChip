module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [7:0] in_reg1;
reg [7:0] in_reg2;
reg [7:0] in_reg3;
reg done_reg;

always @(posedge clk) begin
    if (reset) begin
        in_reg1 <= 8'b0;
        in_reg2 <= 8'b0;
        in_reg3 <= 8'b0;
        done_reg <= 1'b0;
    end else begin
        in_reg3 <= in_reg2;
        in_reg2 <= in_reg1;
        in_reg1 <= in;
        
        if (in_reg1[3] && !in_reg2[3] && !in_reg3[3])
            done_reg <= 1'b1;
        else
            done_reg <= 1'b0;
    end
end

assign done = done_reg;

endmodule

module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

reg [99:0] in_reg;
reg out_and_reg;
reg out_or_reg;
reg out_xor_reg;

always @(*) begin
    in_reg = in;
    out_and_reg = 1'b1;
    out_or_reg = 1'b0;
    out_xor_reg = 1'b0;
    
    for (int i = 0; i < 100; i++) begin
        out_and_reg = out_and_reg & in_reg[i];
        out_or_reg = out_or_reg | in_reg[i];
        out_xor_reg = out_xor_reg ^ in_reg[i];
    end
end

assign out_and = out_and_reg;
assign out_or = out_or_reg;
assign out_xor = out_xor_reg;

endmodule

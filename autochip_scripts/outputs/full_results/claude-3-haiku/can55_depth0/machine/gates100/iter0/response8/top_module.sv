module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

reg result_and, result_or, result_xor;

always @(*) begin
    result_and = 1'b1;
    result_or = 1'b0;
    result_xor = 1'b0;
    
    for (int i = 0; i < 100; i = i + 1) begin
        result_and = result_and & in[i];
        result_or = result_or | in[i];
        result_xor = result_xor ^ in[i];
    end
end

assign out_and = result_and;
assign out_or = result_or;
assign out_xor = result_xor;

endmodule

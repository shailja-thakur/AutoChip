module top_module (
    input [31:0] in,
    output [31:0] out
);
    
    reg [7:0] chunk0, chunk1, chunk2, chunk3;
    wire [7:0] chunk0_out, chunk1_out, chunk2_out, chunk3_out;
    
    assign chunk0_out = chunk0;
    assign chunk1_out = chunk1;
    assign chunk2_out = chunk2;
    assign chunk3_out = chunk3;
    
    always @* begin
        chunk0 = in[7:0];
        chunk1 = in[15:8];
        chunk2 = in[23:16];
        chunk3 = in[31:24];
    end
    
    assign out = {chunk3_out, chunk2_out, chunk1_out, chunk0_out};

endmodule

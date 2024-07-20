module top_module (
    input [31:0] in,
    output [31:0] out
);

    reg [31:0] reversed_byte_order;
    
    always @* begin
        reversed_byte_order[7:0] = in[31:24];
        reversed_byte_order[15:8] = in[23:16];
        reversed_byte_order[23:16] = in[15:8];
        reversed_byte_order[31:24] = in[7:0];
    end
    
    assign out = reversed_byte_order;
    
endmodule

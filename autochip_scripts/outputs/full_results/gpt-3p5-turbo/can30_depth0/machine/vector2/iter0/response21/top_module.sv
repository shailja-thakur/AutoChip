module top_module (
    input [31:0] in,
    output [31:0] out
);
    
    reg [31:0] temp_out;
    
    always @(*) begin
        temp_out[31:24] = in[7:0];
        temp_out[23:16] = in[15:8];
        temp_out[15:8] = in[23:16];
        temp_out[7:0] = in[31:24];
    end
    
    assign out = temp_out;
    
endmodule

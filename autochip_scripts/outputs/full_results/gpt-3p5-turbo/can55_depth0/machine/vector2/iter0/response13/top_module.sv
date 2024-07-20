module top_module (
    input [31:0] in,
    output [31:0] out
);
    
    reg [7:0] out_first_chunk;
    reg [7:0] out_second_chunk;
    reg [7:0] out_third_chunk;
    reg [7:0] out_fourth_chunk;
    
    always @(in)
    begin
        out_first_chunk = in[7:0];
        out_second_chunk = in[15:8];
        out_third_chunk = in[23:16];
        out_fourth_chunk = in[31:24];
        out = {out_fourth_chunk, out_third_chunk, out_second_chunk, out_first_chunk};
    end
    
endmodule

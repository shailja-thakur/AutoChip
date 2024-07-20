module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);
    reg [7:0] start_index;
    reg [3:0] out_temp;
    
    always @* begin
        start_index = sel * 4;
        out_temp = in[start_index + 3 : start_index];
    end
    
    assign out = out_temp;
endmodule

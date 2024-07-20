module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    reg [9:0] start_index;
    wire [9:0] end_index;
    
    always @(*) begin
        start_index = sel * 16;
        end_index = start_index + 15;
        out = in[end_index:end_index-3];
    end
    
endmodule

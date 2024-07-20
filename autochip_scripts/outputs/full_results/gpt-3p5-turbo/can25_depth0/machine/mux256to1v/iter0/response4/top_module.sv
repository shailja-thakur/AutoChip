module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    reg [3:0] temp_index;
    reg [3:0] temp_block;

    always @* begin
        temp_index = sel[3:0];
        temp_block = in[(temp_index*4) +: 4];
        out = temp_block;
    end

endmodule

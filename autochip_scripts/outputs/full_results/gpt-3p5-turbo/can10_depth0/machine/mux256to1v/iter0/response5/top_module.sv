module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    reg [9:0] start_index;
    reg [1023:0] selected_block;

    always @(*) begin
        start_index = sel * 4;
        selected_block = in[start_index + 3 : start_index];
        out = selected_block;
    end

endmodule

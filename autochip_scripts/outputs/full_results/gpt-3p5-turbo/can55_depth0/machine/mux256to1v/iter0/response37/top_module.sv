module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    reg [1023:0] temp;
    reg [7:0] start_index;

    always @(sel) begin
        start_index = sel * 4;
        temp = in[start_index + 3 : start_index];
    end

    assign out = temp;

endmodule

module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output reg [3:0] out
);
reg [9:0] index;

always @ (sel) begin
    case(sel)
        0: index = 0;
        1: index = 4;
        2: index = 8;
        3: index = 12;
        // Continue for all 256 cases
        default: index = 0; // Default case
    endcase
end

always @ (in, index) begin
    out = in[index+3 : index];
end

endmodule

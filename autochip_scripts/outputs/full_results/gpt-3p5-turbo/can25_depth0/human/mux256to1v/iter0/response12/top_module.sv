module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

reg [3:0] temp_out;

always @* begin
    case(sel)
        0: temp_out = in[3:0];
        1: temp_out = in[7:4];
        2: temp_out = in[11:8];
        // add cases for other selections
        default: temp_out = 4'b0; // default value if sel is out of range
    endcase
end

assign out = temp_out;

endmodule

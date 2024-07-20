module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    wire [255:0] in_sel;
    reg [255:0] out_sel;

    assign in_sel = {in[sel*256 +: 256]}; // Extract the selected 256 bits from the input vector

    always @* begin
        case (sel)
            0: out_sel = in_sel[3:0];
            1: out_sel = in_sel[7:4];
            2: out_sel = in_sel[11:8];
            // add more cases for other selections
            default: out_sel = 0; // Default value when select is out of range
        endcase
    end

    assign out = out_sel[3:0];

endmodule

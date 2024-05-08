module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);

    wire [255:0] sel_mask;
    assign sel_mask = 1 << sel;

    wire [255:0] out_data;
    always @(posedge clk) begin
        out_data = in[sel * 8 + sel_mask];
    end

    output [7:0] out_sel;
    assign out_sel = sel;

endmodule
module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);
    reg [7:0] selection_index;

    always @ (*) begin
        selection_index = sel;
    end

    assign out = in[selection_index];

endmodule

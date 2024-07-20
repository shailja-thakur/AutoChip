module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);

    wire [255:0] selected_inputs;
    reg [7:0] shift_sel;
    reg [255:0] shifted_in;

    always @(*) begin
        shift_sel = sel;
        shifted_in = in >> (shift_sel * 8);
    end

    assign selected_inputs = shifted_in;
    assign out = selected_inputs[0];

endmodule

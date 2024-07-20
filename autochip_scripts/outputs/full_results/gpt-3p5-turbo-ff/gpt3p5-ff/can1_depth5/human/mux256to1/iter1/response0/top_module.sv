module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);

    wire [255:0] selected_inputs;
    reg [255:0] shifted_in;

    always @(*) begin
        shifted_in = {in[(sel+1)*8-1:sel*8]};
    end

    assign selected_inputs = shifted_in;
    assign out = selected_inputs[0];

endmodule

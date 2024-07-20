module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);

    reg [7:0] index;
    assign index = sel;
    wire [255:0] selected_vector;

    always @* begin
        selected_vector = in[index];
    end

    assign out = selected_vector[0];

endmodule

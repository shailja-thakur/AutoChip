module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);

wire [255:0] selected_input;

assign selected_input = (sel == 8'b00000000) ? in[0] :
                        (sel == 8'b00000001) ? in[1] :
                        (sel == 8'b00000010) ? in[2] :
                        // Add 253 more conditions for remaining inputs
                        // ...
                        (sel == 8'b11111111) ? in[255] :
                        8'b0; // Default value for selected_input

assign out = selected_input;

endmodule

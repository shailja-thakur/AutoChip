module top_module (
    input [4:0] a,
    input [4:0] b,
    input [4:0] c,
    input [4:0] d,
    input [4:0] e,
    input [4:0] f,
    output [7:0] w,
    output [7:8] x,
    output [7:8] y,
    output [7:8] z 
);

    // Concatenate inputs, append two 1 bits, and then split into 8-bit outputs
    wire [31:0] all_inputs_combined;
    assign all_inputs_combined = {a, b, c, d, e, f, 2'b11};
    
    assign w = all_inputs_combined[31:24];
    assign x = all_inputs_combined[23:16];
    assign y = all_inputs_combined[15:8];
    assign z = all_inputs_combined[7:0];

endmodule

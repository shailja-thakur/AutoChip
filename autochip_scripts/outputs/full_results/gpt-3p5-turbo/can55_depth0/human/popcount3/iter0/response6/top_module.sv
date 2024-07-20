module top_module (
    input [2:0] in,
    output reg [1:0] out
);

    always @(*)
    begin
        out = in[2] + in[1] + in[0];   // Adding the bits produces the population count 
    end

endmodule

module top_module (
    input in1,
    input in2,
    input in3,
    output reg out
);

    // two-input XNOR gate
    wire xnor_output;
    assign xnor_output = ~(in1 ^ in2);
  
    // two-input XOR gate
    always @(xnor_output or in3)
    begin
        out <= xnor_output ^ in3;
    end

endmodule

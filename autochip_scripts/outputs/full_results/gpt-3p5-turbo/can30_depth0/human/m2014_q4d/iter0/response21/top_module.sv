module top_module (
    input clk,
    input in,
    output logic out
);

// Define flip-flop input and output signals
reg d;
wire xor_output;

assign xor_output = in ^ out; // XOR operation between 'in' and 'out' 

always @(posedge clk) begin
    d <= xor_output; // Assign XOR output to the D input of the flip-flop on positive clock edge
    out <= d; // Assign the D input to the output 'out'
end

endmodule

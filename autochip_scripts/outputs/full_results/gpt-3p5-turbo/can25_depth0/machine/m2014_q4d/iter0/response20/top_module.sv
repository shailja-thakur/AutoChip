module top_module (
    input clk,
    input in,
    output logic out
);
    // Creating a flip-flop using always_ff block
    always_ff @(posedge clk) begin
        out <= in ^ out;  // XOR operation to toggle the output
    end
endmodule

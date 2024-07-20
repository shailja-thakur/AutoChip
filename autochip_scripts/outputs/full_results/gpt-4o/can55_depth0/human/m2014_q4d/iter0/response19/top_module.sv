module top_module (
    input clk,
    input in,
    output logic out
);

    logic xor_out;

    // XOR gate
    assign xor_out = in ^ out;

    // D flip-flop, positive edge triggered
    always_ff @(posedge clk) begin
        out <= xor_out;
    end
    
endmodule

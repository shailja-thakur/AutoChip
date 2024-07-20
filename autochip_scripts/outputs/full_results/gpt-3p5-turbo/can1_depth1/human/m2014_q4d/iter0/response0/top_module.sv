module top_module (
    input clk,
    input in,
    output reg out
);

reg dff_out;

// XOR gate
assign out = in ^ dff_out;

// D flip-flop
always @(posedge clk) begin
    dff_out <= out;
end

endmodule

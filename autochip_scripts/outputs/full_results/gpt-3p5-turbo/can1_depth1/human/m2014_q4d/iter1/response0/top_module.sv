module top_module (
    input clk,
    input in,
    output reg out
);

reg dff_out;
reg dff_out_delay;

// XOR gate
assign out = in ^ dff_out_delay;

// D flip-flop
always @(posedge clk) begin
    dff_out <= out;
    dff_out_delay <= dff_out; // introduce a delay for the output
end

endmodule

module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

reg flip_flop;

// Combinational logic
always @ (posedge clk) begin
    if (a && !b) begin
        flip_flop <= 0;
    end else if (!a && b) begin
        flip_flop <= 1;
    end
end

// Output assignments
assign q = flip_flop;
assign state = (flip_flop && !a);

endmodule

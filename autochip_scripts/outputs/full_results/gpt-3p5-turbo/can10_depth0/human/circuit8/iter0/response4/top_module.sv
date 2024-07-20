module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

// Define flip-flop variables
reg p_ff;
reg q_ff;

always @(posedge clock) begin
    // Store the value of 'a' in flip-flops
    p_ff <= a;
    q_ff <= p_ff;
end

// Assign the flip-flop values to output ports
assign p = p_ff;
assign q = q_ff;

endmodule

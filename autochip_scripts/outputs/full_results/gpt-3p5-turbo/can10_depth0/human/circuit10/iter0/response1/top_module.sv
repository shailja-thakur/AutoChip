module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

// Declare memory element
reg q_next;

// Sequential logic
always @(posedge clk) begin
    if (a & !b)
        q_next <= 1'b1;
    else if (!a & !b)
        q_next <= 1'b0;
    else if (state)
        q_next <= 1'b0;
    else
        q_next <= q_next;
end

// Assign outputs
assign q = q_next;
assign state = q_next;

endmodule

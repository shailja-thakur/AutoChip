module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

    initial begin
        Q = 1'b0; // Initialize the output register Q to 0
    end

    always @(posedge clk) begin
        if (L) begin
            Q <= r_in; // If L is high, set Q to the value of r_in
        end else begin
            Q <= q_in; // If L is low, set Q to the value of q_in
        end
    end

endmodule

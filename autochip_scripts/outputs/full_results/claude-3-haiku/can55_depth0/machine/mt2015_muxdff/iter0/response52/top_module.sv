module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

    initial begin
        Q = 1'b0; // Initialize Q to 0
    end

    always @(posedge clk) begin
        if (L) begin
            Q <= r_in; // If L is high, assign r_in to Q
        end else begin
            Q <= q_in; // If L is low, assign q_in to Q
        end
    end

endmodule

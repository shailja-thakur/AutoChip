module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

    initial begin
        Q = 1'b0; // Initialize output register Q to 0
    end

    always @(posedge clk) begin
        if (L) begin
            Q <= r_in; // Assign r_in to Q if L is high
        end else begin
            Q <= q_in; // Assign q_in to Q if L is low
        end
    end

endmodule

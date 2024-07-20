module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q);

    // Initial block to set the initial value of Q
    initial begin
        Q = 0;
    end

    // Always block triggered on the rising edge of the clock signal
    always @(posedge clk) begin
        if (L) begin
            Q <= r_in; // When L is high, select r_in
        end else begin
            Q <= q_in; // When L is low, select q_in
        end
    end

endmodule

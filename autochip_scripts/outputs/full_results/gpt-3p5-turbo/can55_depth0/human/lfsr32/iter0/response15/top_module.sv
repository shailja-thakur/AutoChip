module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] next_q;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            next_q <= 32'h1;
        end else begin
            // Implement Galois LFSR feedback using XOR gates
            next_q[0] <= q[31] ^ q[21] ^ q[1] ^ q[0];
            next_q[1] <= q[0];
            next_q[2] <= q[1];
            next_q[3:31] <= q[2:30];
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1;
        end else begin
            q <= next_q;
        end
    end

endmodule

module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001;  // Reset to 1
        end else begin
            q <= {q[3:0], q[0] ^ q[2]};  // Shift and apply feedback with XOR at bit position 5 (q[4]) and 3 (q[2])
        end
    end
endmodule

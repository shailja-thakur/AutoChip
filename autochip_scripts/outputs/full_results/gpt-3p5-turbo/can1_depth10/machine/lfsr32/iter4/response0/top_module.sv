module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] q_next; // next value of the register

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 32'h1; // reset to initial value
            q_next <= 32'h1;
        end else begin
            q_next <= {q[30:0], q[31] ^ q[21] ^ q[1] ^ q[0]};
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1; // reset to initial value
        end else begin
            q <= q_next; // update q from q_next
        end
    end

endmodule

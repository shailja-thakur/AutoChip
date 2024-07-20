module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] q_next; // next value of the register

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q_next <= 32'h1; // reset q_next to initial value
        end else begin
            q_next <= {q[30:0], q[0] ^ q[30] ^ q[20]}; // update q_next
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1; // reset q to initial value
        end else begin
            q <= q_next; // update q from q_next
        end
    end

endmodule

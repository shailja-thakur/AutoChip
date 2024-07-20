module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

// Internal wires and registers
reg [31:0] q_next;

// Initial value of register
parameter INIT_VALUE = 32'h1;

// Assign initial value to q register
initial begin
    q = INIT_VALUE;
end

// Logic for updating register on rising edge of clk
always @(posedge clk) begin
    if (reset)
        q <= INIT_VALUE;
    else begin
        q <= q_next;
        q_next <= {q[30:0], q[0] ^ q[21] ^ q[1]};
    end
end

endmodule

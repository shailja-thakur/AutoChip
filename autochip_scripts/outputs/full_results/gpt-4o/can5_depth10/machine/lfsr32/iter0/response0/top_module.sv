module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] q_next;

    // Initial block to initialize the register
    initial begin
        q = 32'h1;
    end

    // Always block to update the q register on the rising edge of the clock
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 32'h1;
        end else begin
            q <= q_next;
        end
    end

    // Always block to calculate the next value of q
    always @(*) begin
        q_next = {q[30:0], q[31] ^ q[21] ^ q[1] ^ q[0]};
    end
    
endmodule

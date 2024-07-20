module top_module(
    input clk,
    input reset,
    output reg [31:0] q
);

    reg [31:0] q_next;
    wire feedback;

    assign feedback = q[0] ^ q[21] ^ q[1];

    always @(*) begin
        q_next = {feedback, q[31:1]};
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 32'h1;
        end else begin
            q <= q_next;
        end
    end

endmodule

module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

    wire [511:0] next_q;
    wire [511:0] q_shift_right1 = {1'b0, q[511:1]};
    wire [511:0] q_shift_left1 = {q[510:0], 1'b0};
    
    assign next_q = ~(
            (q_shift_right1 & q & q_shift_left1) |
            (~q_shift_right1 & ~q & ~q_shift_left1) |
            (q_shift_right1 & ~q & ~q_shift_left1)
        );
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_q;
        end
    end

endmodule

module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

reg [2:0] next_q;

always @(posedge clk) begin
    next_q <= q;
    
    case (q)
        0: next_q <= 4;
        4: next_q <= 4;
        5: next_q <= 5;
        6: next_q <= 6;
        default: next_q <= 0;
    endcase

    if (a == 0) begin
        next_q <= 0;
    end
end

always @(posedge clk) begin
    q <= next_q;
end

endmodule

module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

reg [2:0] next_q;

always @(posedge clk) begin
    if (a == 0) begin
        q <= 0;
    end else begin
        case (q)
            0: next_q <= 4;
            4: next_q <= 6;
            6: next_q <= 0;
            default: next_q <= 0;
        endcase
        q <= next_q;
    end
end

endmodule

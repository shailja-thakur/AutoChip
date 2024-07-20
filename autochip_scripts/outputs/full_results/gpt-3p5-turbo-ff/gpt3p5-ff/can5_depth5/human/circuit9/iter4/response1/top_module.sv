module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

reg [2:0] next_q;

always @(posedge clk) begin
    if (a == 1'b1) begin
        case (q)
            3'b000: next_q <= 3'b100;  // q = 4
            3'b100: next_q <= 3'b100;  // q = 4
            3'b010: next_q <= 3'b101;  // q = 5
            3'b110: next_q <= 3'b101;  // q = 5
            3'b001: next_q <= 3'b110;  // q = 6
            3'b011: next_q <= 3'b110;  // q = 6
            default: next_q <= 3'b000; // q = 0
        endcase
    end else begin
        next_q <= 3'b000; // q = 0
    end
end

always @(posedge clk) begin
    q <= next_q;
end

endmodule

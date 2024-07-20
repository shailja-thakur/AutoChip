module top_module (
    input wire clk,
    input wire a,
    output reg [2:0] q
);

reg [2:0] q_next;

always @(posedge clk) begin
    if (a == 1'b1) begin
        case (q)
            3'b000: q_next = 3'b100;  // q = 4
            3'b100: q_next = 3'b100;  // q = 4
            3'b010: q_next = 3'b010;  // q = 2
            3'b110: q_next = 3'b010;  // q = 2
            3'b011: q_next = 3'b110;  // q = 6
            default: q_next = 3'b000; // q = 0
        endcase
    end else begin
        q_next = 3'b000; // q = 0
    end
end

always @(posedge clk) begin
    q <= q_next;
end

endmodule

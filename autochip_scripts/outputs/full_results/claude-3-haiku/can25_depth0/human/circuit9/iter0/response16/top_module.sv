module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

reg [2:0] next_q;

always @(posedge clk) begin
    q <= next_q;
end

always @(*) begin
    case (q)
        3'b000: next_q = 3'b100;
        3'b100: next_q = 3'b100;
        3'b101: next_q = 3'b110;
        3'b110: next_q = 3'b000;
        default: next_q = 3'b001;
    endcase
    
    if (a == 1'b0) begin
        next_q = 3'b000;
    end
end

endmodule

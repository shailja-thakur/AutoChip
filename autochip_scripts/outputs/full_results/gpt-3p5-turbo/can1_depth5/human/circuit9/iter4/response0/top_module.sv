module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

    reg [2:0] q_next;

    always @(posedge clk) begin
        case (q)
            3'b000: q_next = a ? 3'b100 : 3'b001;
            3'b100: q_next = 3'b101;
            3'b101: q_next = 3'b110;
            default: q_next = 3'b000;
        endcase
        q <= q_next;
    end
endmodule

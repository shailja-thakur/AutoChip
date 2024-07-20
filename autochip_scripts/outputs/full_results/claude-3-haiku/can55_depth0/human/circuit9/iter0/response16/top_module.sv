module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

always @(posedge clk) begin
    case (a)
        1'b1: begin
            if (q == 3'b100)
                q <= 3'b100;
            else
                q <= q + 1;
        end
        1'b0: begin
            if (q == 3'b000)
                q <= 3'b001;
            else if (q == 3'b001)
                q <= 3'b000;
            else if (q == 3'b100)
                q <= 3'b000;
            else
                q <= q;
        end
    endcase
end

endmodule

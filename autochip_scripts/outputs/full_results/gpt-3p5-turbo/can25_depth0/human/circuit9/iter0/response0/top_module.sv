module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

always @(posedge clk) begin
    case(q)
        3'b000: begin
                if (a)
                    q <= 3'b100;
            end
        3'b100: begin
                if (a)
                    q <= 3'b100;
                else
                    q <= 3'b000;
            end
        3'b001: begin
                if (a)
                    q <= 3'b010;
            end
        3'b010: begin
                if (a)
                    q <= 3'b011;
                else
                    q <= 3'b001;
            end
        3'b011: begin
                if (a)
                    q <= 3'b100;
                else
                    q <= 3'b011;
            end
        default: q <= 3'b000;
    endcase
end

endmodule

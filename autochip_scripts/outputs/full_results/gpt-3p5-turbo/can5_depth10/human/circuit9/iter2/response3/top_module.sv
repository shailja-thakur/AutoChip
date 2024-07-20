module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

always @(posedge clk) begin
    if (a == 1'b0) begin
        q <= 0;
    end else begin
        case (q)
            0: q <= 4;
            1: q <= 4;
            2: q <= 4;
            3: q <= 4;
            4: begin
                if (q == 4) begin
                    q <= 5;
                end else begin
                    q <= 0;
                end
            end
            default: q <= 0;
        endcase
    end
end

endmodule

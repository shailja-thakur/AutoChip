module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

always @(posedge clk) begin
    case (q)
        0: begin
            if (a == 1)
                q <= 4;
        end
        4: begin
            if (a == 1)
                q <= 5;
        end
        5: begin
            if (a == 1)
                q <= 6;
        end
        6: begin
            if (a == 1)
                q <= 0;
        end
        default: begin
            q <= 0;
        end
    endcase
end

endmodule

module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

always @(posedge clk) begin
    case (q)
        3'b000: begin
            if (a) begin
                q <= 3'b100;
            end else begin
                q <= 3'b000;
            end
        end
        3'b100: begin
            q <= 3'b100;
        end
        3'b101: begin
            q <= 3'b110;
        end
        3'b110: begin
            q <= 3'b000;
        end
        default: begin
            q <= 3'b000;
        end
    endcase
end

endmodule

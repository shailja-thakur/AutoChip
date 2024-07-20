module top_module (
    input clk,
    input a,
    output reg [2:0] q
);
    
always @(posedge clk) begin
    case (q)
        3'b000: begin
            if (a == 1'b1) begin
                q <= 3'b100; // q = 4
            end else begin
                q <= 3'b000; // q = 0
            end
        end
        3'b100: begin
            if (a == 1'b1) begin
                q <= 3'b100; // q = 4
            end else begin
                q <= 3'b000; // q = 0
            end
        end
        3'b101: begin
            if (a == 1'b1) begin
                q <= 3'b010; // q = 2
            end else begin
                q <= 3'b010; // q = 2
            end
        end
        3'b010: begin
            if (a == 1'b1) begin
                q <= 3'b010; // q = 2
            end else begin
                q <= 3'b000; // q = 0
            end
        end
        3'b011: begin
            if (a == 1'b1) begin
                q <= 3'b110; // q = 6
            end else begin
                q <= 3'b000; // q = 0
            end
        end
        3'b110: begin
            if (a == 1'b1) begin
                q <= 3'b110; // q = 6
            end else begin
                q <= 3'b000; // q = 0
            end
        end
        default: begin
            if (a == 1'b1) begin
                q <= 3'b000; // q = 0
            end else begin
                q <= 3'b000; // q = 0
            end
        end
    endcase
end

endmodule

module top_module (
    input clk,
    input a,
    output reg [2:0] q
);
    
always @(posedge clk) begin
    case (q)
        0: 
            if (a == 0) begin
                q <= 4;
            end else begin
                q <= 1;
            end
        1: 
            if (a == 0) begin
                q <= 0;
            end else begin
                q <= 5;
            end
        4:
            if (a == 0) begin
                q <= 4;
            end else begin
                q <= 5;
            end
        default:
            q <= 0;
    endcase
end

endmodule

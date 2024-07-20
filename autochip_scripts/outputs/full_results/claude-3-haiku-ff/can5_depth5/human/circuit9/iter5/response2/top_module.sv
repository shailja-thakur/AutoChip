module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

always @(posedge clk) begin
    if (a) begin
        case (q)
            3'd0: q <= 3'd1;
            3'd1: q <= 3'd2;
            3'd2: q <= 3'd3;
            3'd3: q <= 3'd4;
            3'd4: q <= 3'd5;
            3'd5: q <= 3'd6;
            3'd6: q <= 3'd0;
            default: q <= 3'd0;
        endcase
    end
    else begin
        q <= 3'd0;
    end
end

endmodule

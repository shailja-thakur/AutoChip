module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

always @(posedge clk) begin
    if (a) begin
        case (q)
            3'd4: q <= 3'd5; // 4 => 5
            3'd5: q <= 3'd6; // 5 => 6
            3'd6: q <= 3'd0; // 6 => 0
            default: q <= q + 3'd1; // Increment q
        endcase
    end else begin
        q <= 3'd0; // Reset q to 0
    end
end

endmodule

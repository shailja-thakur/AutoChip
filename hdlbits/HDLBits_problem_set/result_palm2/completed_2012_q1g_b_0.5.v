module top_module (
    input [4:1] x,
    output f
); 

    always @(posedge clk) begin
        if (reset) begin
            f <= 1'b0;
        end else begin
            f <= (x[3:1] == 3'b001) || (x[3:1] == 3'b110);
        end
    end

endmodule
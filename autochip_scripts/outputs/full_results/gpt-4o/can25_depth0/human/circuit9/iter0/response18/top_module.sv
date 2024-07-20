module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

    always @(posedge clk) begin
        if (a == 1'b1) begin
            q <= 3'b100;
        end else begin
            q <= q + 1'b1;
            if(q == 3'b110) q <= 3'b000; // Reset q to 0 when it reaches 6 (binary 110)
        end
    end

endmodule

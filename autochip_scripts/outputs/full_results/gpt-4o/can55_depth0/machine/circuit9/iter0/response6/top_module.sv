module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

    always @(posedge clk) begin
        if (a == 1) begin
            q <= 3'b100;  // Set q to 4 when a is 1
        end
        else begin
            if (q == 3'b110) begin  // When q is 6
                q <= 3'b000;        // Set q to 0
            end
            else begin
                q <= q + 3'b001;  // Increase q by 1
            end
        end
    end
endmodule

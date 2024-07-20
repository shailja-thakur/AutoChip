module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

    // Initialize q to zero
    initial begin
        q = 3'b000;
    end

    always @(posedge clk) begin
        if (a == 1) begin
            q <= 3'b100;
        end else if (a == 0) begin
            if (q == 3'b110) begin
                q <= 3'b000;
            end else begin
                q <= q + 1;
            end
        end
    end

endmodule

module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

    always @(posedge clk) begin
        if (a == 1) begin
            q <= 3'b100;  // Set q to 4
        end else begin
            if (q == 3'b110) begin
                q <= 3'b000;  // Set q to 0 when q is 6
            end else begin
                q <= q + 3'b001;  // Increment q by 1
            end
        end
    end

endmodule

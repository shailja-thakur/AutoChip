module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

    always @(posedge clk) begin
        if (a) begin
            q <= 3'b100; // When a is 1, set q to 4
        end else begin
            if (q == 3'b111) begin
                q <= 3'b000; // Reset q to 0 when reaching 7
            end else begin
                q <= q + 1; // Increment q otherwise
            end
        end
    end

endmodule

module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

    always @(posedge clk) begin
        if(a) begin
            q <= 3'b100;
        end else begin
            q <= q + 3'b001;
            if (q == 3'b110) begin
                q <= 3'b000;
            end
        end
    end

endmodule

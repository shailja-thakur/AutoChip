module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

    initial begin
        q = 3'bxxx; // initialize q to unknown value
    end

    always @(posedge clk) begin
        if (a) begin
            if (q == 3'bxxx) begin
                q <= 3'd4;
            end
        end else begin
            if (q == 3'd4) begin
                q <= 3'd4;
            end else begin
                q <= q + 1;
                if (q == 3'd6) begin
                    q <= 3'd0;
                end
            end
        end
    end

endmodule

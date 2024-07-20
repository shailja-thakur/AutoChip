module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

    // Initialize q to the required start state
    initial begin
        q = 3'bxxx;
    end

    always @(posedge clk) begin
        if (q === 3'bxxx) begin
            q <= 3'd4;
        end else if (a == 1'b1) begin
            q <= 3'd4;
        end else begin
            if (q == 3'd6) begin
                q <= 3'd0;
            end else begin
                q <= q + 3'd1;
            end
        end
    end

endmodule

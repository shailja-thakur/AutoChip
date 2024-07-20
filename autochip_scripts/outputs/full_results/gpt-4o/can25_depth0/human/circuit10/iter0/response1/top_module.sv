module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        if (a == 1'b1 && b == 1'b1) begin
            q <= ~q;
        end else begin
            q <= q;
        end
        
        if (a == 1'b1 && b == 1'b1) begin
            state <= q;
        end else begin
            state <= ~q;
        end
    end

    initial begin
        q = 0;
        state = 0;
    end

endmodule

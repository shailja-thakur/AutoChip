module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);
    always @(posedge clk) begin
        if (state == 0) begin
            if (a == 0 && b == 0)
                state <= 0;
            else if (a == 0 && b == 1)
                state <= 1;
            else if (a == 1 && b == 0)
                state <= 2;
            else if (a == 1 && b == 1)
                state <= 3;
        end else begin
            state <= 0;
        end

        if (state == 0)
            q <= 0;
        else if (state == 1)
            q <= 1;
        else if (state == 2)
            q <= 1;
        else if (state == 3)
            q <= 0;
    end
endmodule

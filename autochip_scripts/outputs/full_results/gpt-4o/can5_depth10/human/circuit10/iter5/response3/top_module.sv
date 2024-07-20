module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        // State capture logic - state toggles based on a and b
        if (a == 1'b1 && b == 1'b1) begin
            state <= ~state;
        end else if (b == 1'b1) begin
            state <= 1'b0;
        end else begin
            state <= a;
        end
    end

    always @(posedge clk) begin
        // Output logic - q changes based on a and state
        if (a == 1'b1 && b == 1'b0) begin
            q <= 1'b1;
        end else if (a == 1'b0 && b == 1'b1) begin
            q <= state;
        end else if (a == 1'b1 && b == 1'b1) begin
            q <= ~q;
        end else begin
            q <= 1'b0;
        end
    end

endmodule

module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg q
);

    always @ (*) begin
        if (a == 0 && b == 0 && c == 0 && d == 0) begin
            q <= 0;
        end else if (a == 0 && b == 0 && c == 0 && d == 1) begin
            q <= 0;
        end else if (a == 0 && b == 0 && c == 1 && d == 0) begin
            q <= 0;
        end else if (a == 0 && b == 0 && c == 1 && d == 1) begin
            q <= 0;
        end else if (a == 0 && b == 1 && c == 0 && d == 0) begin
            q <= 1;
        end else if (a == 0 && b == 1 && c == 0 && d == 1) begin
            q <= 1;
        end else if (a == 0 && b == 1 && c == 1 && d == 0) begin
            q <= 1;
        end else if (a == 0 && b == 1 && c == 1 && d == 1) begin
            q <= 1;
        end else if (a == 1 && b == 0 && c == 0 && d == 0) begin
            q <= 0;
        end else if (a == 1 && b == 0 && c == 0 && d == 1) begin
            q <= 1;
        end else if (a == 1 && b == 0 && c == 1 && d == 0) begin
            q <= 1;
        end else if (a == 1 && b == 0 && c == 1 && d == 1) begin
            q <= 1;
        end else if (a == 1 && b == 1 && c == 0 && d == 0) begin
            q <= 0;
        end else if (a == 1 && b == 1 && c == 0 && d == 1) begin
            q <= 1;
        end else if (a == 1 && b == 1 && c == 1 && d == 0) begin
            q <= 1;
        end else if (a == 1 && b == 1 && c == 1 && d == 1) begin
            q <= 1;
        end
    end

endmodule

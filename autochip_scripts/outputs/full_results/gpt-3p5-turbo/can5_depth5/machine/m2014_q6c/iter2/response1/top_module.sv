module top_module (
    input [6:1] y,
    input w,
    output reg Y2,
    output reg Y4
);
    wire [3:0] y_sub;

    always @* begin
        Y2 = y[1] & ~w;
        y_sub = {y[6], y[5], y[3], y[2]};
        Y4 = y_sub & w;
    end
endmodule

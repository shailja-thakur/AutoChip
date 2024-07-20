module top_module (
    input [6:1] y,
    input w,
    output reg Y2,
    output reg Y4
);

    wire [3:0] temp_y; // to store selected bits of y

    // Select bits 2, 3, 5, 6 of y
    assign temp_y = {y[6], y[5], y[3], y[2]};

    // Generate Y2 by taking the logical AND of the first bit of y and the logical NOT of w
    always @(*) begin
        Y2 = y[1] & ~w;
    end

    // Generate Y4 by taking the logical AND of selected bits of y and w
    always @(*) begin
        Y4 = temp_y & w;
    end

endmodule

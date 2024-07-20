module top_module(
    input x,
    input y,
    output z);

    reg prev_x;
    reg prev_y;
    reg prev_z;

    always @(posedge clk) begin
        prev_x <= x;
        prev_y <= y;
        prev_z <= z;
    end

    always @(prev_x or prev_y or prev_z) begin
        if (prev_x && prev_y) begin
            z <= 1;
        end else if (!prev_x || !prev_y) begin
            z <= 0;
        end
    end

endmodule

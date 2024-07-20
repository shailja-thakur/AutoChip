module top_module(
    output reg zero);

    always @(posedge clk or negedge rst)
    begin
        if (rst == 0)
            zero <= 0;
    end

endmodule

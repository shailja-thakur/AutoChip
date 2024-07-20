module top_module(
    output reg zero);

    always @(posedge clk or negedge rst_n) begin
        if(rst_n == 0) begin
            zero <= 0;
        end else begin
            zero <= 0;
        end
    end
endmodule

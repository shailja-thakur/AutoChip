module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
);

    bcdcount counter0 (clk, reset, c_enable[0], Q0);
    bcdcount counter1 (clk, reset, c_enable[1], Q1);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            OneHertz <= 1'b0;
        end else if (Q0 == 9'b9999) begin
            OneHertz <= 1'b1;
            Q0 <= 0;
        end
    end

endmodule
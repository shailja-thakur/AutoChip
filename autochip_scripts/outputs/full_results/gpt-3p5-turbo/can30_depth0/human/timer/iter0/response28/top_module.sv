module top_module(
    input clk,
    input load,
    input [9:0] data,
    output tc
);

reg [9:0] counter;
reg tc_reg;
assign tc = tc_reg;

always @(posedge clk) begin
    // counts down when load is 0
    if (load == 1'b0) begin
        if (counter > 0) begin
            counter <= counter - 1;
        end else begin
            tc_reg <= 1'b1;
        end
    end

    // loads counter when load is 1
    if (load == 1'b1) begin
        counter <= data;
        tc_reg <= 1'b0;
    end
end

endmodule

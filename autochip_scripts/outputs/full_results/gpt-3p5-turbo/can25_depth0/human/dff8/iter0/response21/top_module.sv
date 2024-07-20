module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);

    reg [7:0] q_reg; // create a register to store the current value of q

    always @(posedge clk)
    begin
        q_reg <= d; // store the input value d in q_reg when clk rises
    end

    assign q = q_reg; // assign the value stored in q_reg to output q

endmodule

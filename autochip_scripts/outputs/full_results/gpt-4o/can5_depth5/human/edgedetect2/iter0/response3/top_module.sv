module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

    reg [7:0] prev_in;

    always @(posedge clk) begin
        anyedge <= (in & ~prev_in);  // Detect rising edge (0 to 1 transition)
        prev_in <= in;  // Store the previous value of 'in' for the next clock cycle
    end

endmodule

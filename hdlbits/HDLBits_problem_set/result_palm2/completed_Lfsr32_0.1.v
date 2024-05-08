module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 32'h1
    output [31:0] q
); 

    parameter WIDTH = 32;

    reg [WIDTH-1:0] state;
    reg [WIDTH-1:0] next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 32'h1;
        end else begin
            next_state <= state ^ (state >> 22) ^ (state >> 2) ^ state[1];
            state <= next_state;
        end
    end

    assign q = state;

endmodule
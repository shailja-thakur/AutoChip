module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    // Register to store the current state of the LFSR
    reg [4:0] state;

    always @(posedge clk) begin
        if (reset) begin
            state <= 5'b1;
        end else begin
            state[4] <= state[3] ^ state[0]; // fix tap positions
            state[3:0] <= state[4:1]; // fix shift positions
        end
    end

    assign q = state;

endmodule

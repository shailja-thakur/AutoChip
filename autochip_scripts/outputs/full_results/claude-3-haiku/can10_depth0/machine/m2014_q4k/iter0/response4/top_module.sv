module top_module (
    input clk,
    input resetn,
    input in,
    output reg out
);

    reg [3:0] sr; // 4-bit shift register

    always @(posedge clk) begin
        if (~resetn) begin
            sr <= 4'b0000; // reset to all zeros
        end
        else begin
            sr <= {sr[2:0], in}; // shift left and load input into LSB
            out <= sr[3]; // output MSB
        end
    end

endmodule

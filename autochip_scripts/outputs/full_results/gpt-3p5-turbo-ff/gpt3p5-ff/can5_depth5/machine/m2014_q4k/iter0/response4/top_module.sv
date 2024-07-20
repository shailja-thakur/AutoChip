module top_module (
    input clk,
    input resetn,
    input in,
    output out
);

    reg [3:0] sr; // 4-bit shift register

    always @(posedge clk) begin
        if (!resetn) begin    // reset the register to all zeros
            sr <= 4'b0000;
        end else begin
            sr <= {sr[2:0], in};    // shift left by one bit and load input into the least significant bit
        end
    end

    assign out = sr[3];    // output is the most significant bit of the register

endmodule

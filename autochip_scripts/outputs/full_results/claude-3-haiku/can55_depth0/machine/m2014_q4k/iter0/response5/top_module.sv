module top_module (
    input clk,
    input resetn,
    input in,
    output out
);

    reg [3:0] sr; // 4-bit shift register

    always @(posedge clk) begin
        if (!resetn) begin
            sr <= 4'b0000; // reset the register to all zeros
        end
        else begin
            sr <= {sr[2:0], in}; // shift left by 1 bit and load input into LSB
        end
    end

    assign out = sr[3]; // output the MSB of the register

endmodule

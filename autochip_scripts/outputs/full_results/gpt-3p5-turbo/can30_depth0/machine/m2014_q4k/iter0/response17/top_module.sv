module top_module (
    input clk,
    input resetn,
    input in,
    output out
);
    reg [3:0] sr;      // 4-bit register to store data

    always @(posedge clk) begin
        if (resetn == 1'b0) begin
            sr <= 4'b0;      // reset register to all zeros
        end else begin
            sr <= {sr[2:0], in};    // shift register left by one bit and load input into the least significant bit
        end
    end

    assign out = sr[3];    // output is the most significant bit of the register

endmodule

module top_module (
    input clk,
    input resetn,
    input in,
    output out
);

    reg [3:0] sr; // 4-bit shift register

    always @(posedge clk) begin
        if (!resetn) begin
            sr <= 4'b0000; // reset register to all zeros
        end
        else begin
            sr <= {sr[2:0], in}; // shift left by one bit, load input into LSB
        end
    end

    assign out = sr[3]; // output is MSB of register

endmodule

module top_module (
    input clk,
    input resetn,
    input in,
    output out
);

    reg [3:0] sr; // 4-bit shift register

    assign out = sr[3]; // Output is the most significant bit

    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            sr <= 4'b0000; // Reset register to all zeros when resetn is low
        else
            sr <= {sr[2:0], in}; // Shift left and load the input into LSB
    end

endmodule

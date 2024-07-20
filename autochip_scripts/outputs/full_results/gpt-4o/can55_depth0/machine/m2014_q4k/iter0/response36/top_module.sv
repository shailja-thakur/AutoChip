module top_module (
    input clk,
    input resetn,
    input in,
    output out
);
    reg [3:0] sr;

    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            sr <= 4'b0000;             // Reset shift register to 0
        else
            sr <= {sr[2:0], in};       // Shift left and load input into LSB
    end

    assign out = sr[3];                 // Output the MSB of the shift register

endmodule

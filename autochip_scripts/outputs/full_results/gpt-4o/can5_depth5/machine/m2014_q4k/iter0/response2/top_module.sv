module top_module (
    input clk,
    input resetn,
    input in,
    output out
);

    reg [3:0] sr;

    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            sr <= 4'b0000; // Reset the register to all zeros
        else
            sr <= {sr[2:0], in}; // Shift left and load the input into the LSB
    end

    assign out = sr[3]; // Output the MSB of the register

endmodule

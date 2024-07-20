module top_module (
    input clk,
    input resetn,
    input in,
    output out
);

    reg [3:0] sr; // Shift register

    always @(posedge clk) begin
        if (~resetn) begin
            sr <= 4'b0; // Synchronous reset
        end
        else begin
            sr <= {sr[2:0], in}; // Shift in the input
        end
    end

    assign out = sr[3]; // Output is the most significant bit

endmodule

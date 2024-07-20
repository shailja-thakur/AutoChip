module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] lfsr;
    reg feedback;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            lfsr <= 5'b11111;
        end else begin
            feedback <= lfsr[4] ^ lfsr[2]; // Feedback calculation
            lfsr <= {lfsr[3:0], feedback}; // Shifting the register
        end
    end

    assign q = lfsr;

endmodule

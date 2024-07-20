module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] reg;  // Shift register

    always @(posedge clk) begin
        if (reset) begin
            reg <= 32'h1;  // Reset the shift register
            q <= 32'h1;    // Reset the output
        end else begin
            reg <= {reg[31:1], reg[22] ^ reg[2] ^ reg[1] ^ reg[0]};  // Calculate the next state
            q <= reg;  // Assign the output
        end
    end

endmodule

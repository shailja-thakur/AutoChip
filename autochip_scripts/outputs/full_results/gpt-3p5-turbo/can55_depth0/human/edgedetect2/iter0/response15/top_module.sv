module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

    reg [7:0] in_reg; // Register to store previous input values
    
    always @(posedge clk) begin
        in_reg <= in; // Store current input values in the register
    end
    
    always @* begin
        anyedge = 0; // Initialize the output
        for (int i = 0; i < 8; i = i + 1) begin
            if (in_reg[i] == 0 && in[i] == 1) begin
                anyedge[i] = 1; // Detect 0 to 1 transition and set the output bit
            end
        end
    end

endmodule

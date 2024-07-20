module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);
    
    reg [31:0] in_prev;
    reg [31:0] out_reg; // Separate register for keeping the output value
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            in_prev <= 32'h0;
        else
            in_prev <= in;
    end
    
    always @(posedge clk) begin
        out_reg <= (in_prev & ~in) | (out_reg & ~reset); // Use out_reg instead of out here
    end
    
    always @(posedge clk) begin
        if (reset)
            out <= 32'h0;
        else
            out <= out_reg; // Assign out_reg to the output
    end
    
endmodule

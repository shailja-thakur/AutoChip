module top_module(
    input clk,
    input reset,
    output reg [31:0] q);
    
    reg [31:0] feedback;
    
    // Reset logic
    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1;
        end else begin
            feedback <= {q[0] ^ q[9] ^ q[29] ^ q[30], q[31:1]};
            q <= feedback;
        end
    end
    
endmodule

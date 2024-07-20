module top_module(
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q);
    
    // Define internal signal
    reg [15:0] register;
    
    always @(posedge clk) begin
        if (!resetn) begin
            register <= 16'b0;
        end else begin
            if (byteena[0]) begin
                register[7:0] <= d[7:0];
            end
            if (byteena[1]) begin
                register[15:8] <= d[15:8];
            end
        end
    end
    
    assign q = register;
    
endmodule

module top_module (
    input clk,
    input enable,
    input S,
    input A,
    input B,
    input C,
    output reg Z
);

    reg [7:0] q;
    wire [2:0] address;
    
    always @(posedge clk) begin
        if (enable) begin
            q <= {q[6:0], S};
        end
    end
    
    assign address = {A, B, C};
    assign Z = q[address];
    
endmodule

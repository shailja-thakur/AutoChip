module top_module(
    input clk,
    input [7:0] d,
    input areset,
    output reg [7:0] q
);

    reg [7:0] q_temp;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            q_temp <= 8'b0;
        end else begin
            q_temp <= d;
        end
    end
    
    assign q = q_temp;
    
endmodule

module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

    always @(posedge clk) begin
        if (a == 1'b1) begin
            q <= 3'b100; // q is set to 4 when a is 1
        end else begin
            if (q == 3'b110) begin
                q <= 3'b000; // reset when q reaches 6
            end else begin
                q <= q + 1'b1; // increment q otherwise
            end
        end
    end
    
endmodule

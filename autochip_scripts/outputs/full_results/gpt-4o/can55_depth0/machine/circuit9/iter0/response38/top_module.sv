module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);
    
    // Reset state
    initial begin
        q = 3'b000;
    end

    // Mealy machine
    always @(posedge clk) begin
        if (a == 1'b1) begin
            q <= 3'b100; // set q to 4
        end else begin
            if (q == 3'b110) begin
                q <= 3'b000; // set q to 0 if q is 6
            end else begin
                q <= q + 1; // increase q by 1
            end
        end
    end

endmodule

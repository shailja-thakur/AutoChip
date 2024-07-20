module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

    initial begin
        q = 3'bxxx; // Initialize q to unknown state
    end

    always @(posedge clk) begin
        if (a == 1'b1) begin
            q <= 3'b100; // Setting q to 4 when a is 1
        end else begin
            if(q == 3'b100)
                q <= 3'b101;  // Incrementing q when it is 4 and a is 0
            else if(q == 3'b101)
                q <= 3'b110;  // Incrementing q when it is 5 and a is 0
            else if(q == 3'b110)
                q <= 3'b000;  // Resetting q when it is 6 and a is 0
            else
                q <= q + 1;   // Incrementing q in all other cases
        end
    end

endmodule

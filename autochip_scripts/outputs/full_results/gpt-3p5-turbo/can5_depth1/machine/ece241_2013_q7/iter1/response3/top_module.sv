module top_module (
    input clk,
    input j,
    input k,
    output reg Q
);

    reg Q_next; // Temporary storage for Q value
    
    always @(posedge clk) begin
        if (j & ~Q)
            Q_next <= 1'b1;
        else if (~k & Q)
            Q_next <= 1'b0;
        else if (j & k)
            Q_next <= ~Q;
    end
    
    always @(posedge clk) begin
        Q <= Q_next; // Assign Q_next to Q
    end
    
endmodule

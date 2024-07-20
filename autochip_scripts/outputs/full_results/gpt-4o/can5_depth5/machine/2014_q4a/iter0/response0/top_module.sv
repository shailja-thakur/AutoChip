module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);
    
    always @(posedge clk) begin
        if (R) begin
            Q <= 1'b0; // Reset the register to a known state
        end else if (E) begin
            if (L) begin
                Q <= R;  // Load with the value of R
            } else begin
                Q <= w;  // Load with the value of w
            end
        end
        // Else, Q holds its state due to the lack of an else block for E being low
    end
    
endmodule

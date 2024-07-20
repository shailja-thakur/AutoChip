module top_module (
    input clk,
    input a,
    output reg [2:0] q
);
    // Output reset
    initial q = 0;
    
    always @(posedge clk) begin
        if (a == 1) begin
            q <= 3'd4;
        end else begin
            // Counting Sequence: 4 -> 5 -> 6 -> 0 -> 1
            case (q)
                3'd4: q <= 3'd5;
                3'd5: q <= 3'd6;
                3'd6: q <= 3'd0;
                3'd0: q <= 3'd1;
                3'd1: q <= 3'd1; // Stay at 1 when `a` is 0
                default: q <= 3'd0; // Default case to safe guard unexpected states
            endcase
        end
    end
endmodule

module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

always @(posedge clk) begin
    if (a == 0) begin
        q <= 0;
    end else begin
        case (q)
            0: q <= 4;
            4: q <= 4;
            5: q <= 5;
            // Add missing cases to handle exceptional values
            6: q <= 6;
            default: q <= 0; // Assign a default value for any other value of q
        endcase
    end
end

endmodule

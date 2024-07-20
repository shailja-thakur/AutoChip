module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

// Initial state of q
initial begin
    q <= 0;
end

always @(posedge clk) begin
    if (a == 0) begin
        q <= q;  // Retain current value of q
    end else begin
        case (q)
            0: q <= 1;
            1: q <= 2;
            2: q <= 3;
            3: q <= 4;
            4: q <= 5;
            default: q <= q;  // Retain current value of q
        endcase
    end
end

endmodule

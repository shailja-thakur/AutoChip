module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

    always @(posedge clk) begin
        if (a) begin
            q <= 3'b100;  // Set q to 4 when a is 1
        end else begin
            case (q)
                3'b000: q <= 3'b001; // 0 to 1
                3'b001: q <= 3'b010; // 1 to 2
                3'b010: q <= 3'b011; // 2 to 3
                3'b011: q <= 3'b100; // 3 to 4
                3'b100: q <= 3'b101; // 4 to 5
                3'b101: q <= 3'b110; // 5 to 6
                3'b110: q <= 3'b000; // 6 to 0
                default: q <= 3'b000;
            endcase
        end
    end
    
endmodule

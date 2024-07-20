module top_module (
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);
    reg [2:0] count;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 3'b0;
            q <= 16'b0;
        end else if (ena[3]) begin
            count <= count + 1;
            if (count == 3'b100) begin
                count <= 3'b0;
            end
        end
    end
    
    always @(*) begin
        case (count)
            3'b000: q = 4'b0000;
            3'b001: q = 4'b0001;
            3'b010: q = 4'b0010;
            3'b011: q = 4'b0011;
            3'b100: q = 4'b0000;
            default: q = 4'b0000;
        endcase
    end
    
    assign ena[1] = 1;
    assign ena[2] = 1;
    assign ena[3] = 1;
endmodule

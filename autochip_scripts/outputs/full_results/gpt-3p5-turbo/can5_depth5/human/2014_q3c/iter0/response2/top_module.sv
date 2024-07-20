module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);
    
    always @(posedge clk) begin
        case (y)
            3'b000: begin
                if (x)
                    {Y0,z} <= 2'b01;
                else
                    {Y0,z} <= 2'b00;
            end
            3'b001: begin
                if (x)
                    {Y0,z} <= 2'b10;
                else
                    {Y0,z} <= 2'b00;
            end
            3'b010: begin
                if (x)
                    {Y0,z} <= 2'b01;
                else
                    {Y0,z} <= 2'b00;
            end
            3'b011: begin
                if (x)
                    {Y0,z} <= 2'b10;
                else
                    {Y0,z} <= 2'b01;
            end
            3'b100: begin
                if (x)
                    {Y0,z} <= 2'b11;
                else
                    {Y0,z} <= 2'b10;
            end
        endcase
    end
    
endmodule

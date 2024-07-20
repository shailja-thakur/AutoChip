module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] y, next_y;
reg z_next;

always @(posedge clk, posedge reset)
begin
    if (reset)
        y <= 3'b000;
    else
        y <= next_y;
end

always @(*)
begin
    case (y)
        3'b000: begin
            if (x)
                next_y = 3'b001;
            else
                next_y = 3'b000;
                
            z_next = 1'b0;
        end
        
        3'b001: begin
            if (x)
                next_y = 3'b100;
            else
                next_y = 3'b001;
                
            z_next = 1'b0;
        end
        
        3'b010: begin
            if (x)
                next_y = 3'b001;
            else
                next_y = 3'b010;
                
            z_next = 1'b0;
        end
        
        3'b011: begin
            if (x)
                next_y = 3'b010;
            else
                next_y = 3'b001;
                
            z_next = 1'b1;
        end
        
        3'b100: begin
            if (x)
                next_y = 3'b100;
            else
                next_y = 3'b011;
                
            z_next = 1'b1;
        end
    endcase
end

always @(posedge clk)
begin
    z <= z_next;
end

endmodule

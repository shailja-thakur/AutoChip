module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] y, next_y;
reg [1:0] next_z;

always @(posedge clk or posedge reset) begin
    if (reset)
        y <= 3'b000;
    else
        y <= next_y;
end

always @* begin
    case (y)
        3'b000: begin
            if (x)
                next_y = 3'b001;
            else
                next_y = 3'b000;
            next_z = 2'b01;
        end
        
        3'b001: begin
            if (x)
                next_y = 3'b100;
            else
                next_y = 3'b001;
            next_z = 2'b01;
        end
        
        3'b010: begin
            if (x)
                next_y = 3'b001;
            else
                next_y = 3'b010;
            next_z = 2'b01;
        end
        
        3'b011: begin
            if (x)
                next_y = 3'b010;
            else
                next_y = 3'b001;
            next_z = 2'b10;
        end
        
        3'b100: begin
            if (x)
                next_y = 3'b100;
            else
                next_y = 3'b011;
            next_z = 2'b10;
        end
    endcase
end

always @(posedge clk or posedge reset) begin
    if (reset)
        z <= 1'b0;
    else
        z <= next_z;
end

endmodule

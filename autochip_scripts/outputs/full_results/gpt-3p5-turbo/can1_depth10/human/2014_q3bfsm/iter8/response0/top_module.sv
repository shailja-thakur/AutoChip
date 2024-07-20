module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] y, y_next;
reg [2:0] y_reg;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        y <= 3'b000;
        z <= 1'b0;
    end else begin
        y <= y_next;
        z <= z; 
    end
end

always @(y or x) begin
    y_reg <= y; // Add a separate register to store the present state
    case(y_reg) // Use y_reg instead of y in the case statement
        3'b000: begin
            if (x)
                y_next = 3'b001;
            else
                y_next = 3'b010;
            z <= 1'b0;
        end
        3'b001: begin
            if (x)
                y_next = 3'b100;
            else
                y_next = 3'b001;
            z <= 1'b0;
        end
        3'b010: begin
            if (x)
                y_next = 3'b001;
            else
                y_next = 3'b010;
            z <= 1'b0;
        end
        3'b011: begin
            if (x)
                y_next = 3'b010;
            else
                y_next = 3'b001;
            z <= 1'b1;
        end
        3'b100: begin
            if (x)
                y_next = 3'b100;
            else
                y_next = 3'b011;
            z <= 1'b1;
        end
        default: begin
            y_next = 3'b000;
            z <= 1'b0;
        end
    endcase
end

endmodule

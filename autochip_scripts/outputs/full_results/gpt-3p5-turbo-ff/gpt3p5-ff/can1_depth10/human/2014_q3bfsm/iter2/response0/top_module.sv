module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] y, next_y;

always @(posedge clk) begin
    if (reset) begin
        y <= 3'b000;
    end else begin
        y <= next_y;
    end
end

always @(y or x) begin
    case (y)
        3'b000:
            begin
                if (x) begin
                    next_y = 3'b001;
                    z <= 1'b0; // Fix: Assign value to z using nonblocking assignment
                end else begin
                    next_y = 3'b000;
                    z <= 1'b0; // Fix: Assign value to z using nonblocking assignment
                end
            end
        3'b001:
            begin
                if (x) begin
                    next_y = 3'b100;
                    z <= 1'b0; // Fix: Assign value to z using nonblocking assignment
                end else begin
                    next_y = 3'b001;
                    z <= 1'b0; // Fix: Assign value to z using nonblocking assignment
                end
            end
        3'b010:
            begin
                if (x) begin
                    next_y = 3'b001;
                    z <= 1'b0; // Fix: Assign value to z using nonblocking assignment
                end else begin
                    next_y = 3'b010;
                    z <= 1'b0; // Fix: Assign value to z using nonblocking assignment
                end
            end
        3'b011:
            begin
                if (x) begin
                    next_y = 3'b001;
                    z <= 1'b1; // Fix: Assign value to z using nonblocking assignment
                end else begin
                    next_y = 3'b010;
                    z <= 1'b1; // Fix: Assign value to z using nonblocking assignment
                end
            end
        3'b100:
            begin
                if (x) begin
                    next_y = 3'b100;
                    z <= 1'b1; // Fix: Assign value to z using nonblocking assignment
                end else begin
                    next_y = 3'b011;
                    z <= 1'b1; // Fix: Assign value to z using nonblocking assignment
                end
            end
        default: begin
            next_y = 3'b000;
            z <= 1'b0; // Fix: Assign value to z using nonblocking assignment
        end
    endcase
end

endmodule

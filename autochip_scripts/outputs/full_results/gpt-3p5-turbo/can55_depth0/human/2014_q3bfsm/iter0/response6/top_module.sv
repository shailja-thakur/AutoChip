module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] y;
always @(posedge clk or posedge reset) begin
    if (reset) begin
        y <= 3'b000;
    end else begin
        case (y)
            3'b000: begin
                if (x) begin
                    y <= 3'b001;
                    z <= 1'b0;
                end else begin
                    y <= 3'b000;
                    z <= 1'b0;
                end
            end
            
            3'b001: begin
                if (x) begin
                    y <= 3'b100;
                    z <= 1'b0;
                end else begin
                    y <= 3'b001;
                    z <= 1'b0;
                end
            end
            
            3'b010: begin
                if (x) begin
                    y <= 3'b001;
                    z <= 1'b0;
                end else begin
                    y <= 3'b010;
                    z <= 1'b0;
                end
            end
            
            3'b011: begin
                if (x) begin
                    y <= 3'b010;
                    z <= 1'b1;
                end else begin
                    y <= 3'b001;
                    z <= 1'b0;
                end
            end
            
            3'b100: begin
                if (x) begin
                    y <= 3'b100;
                    z <= 1'b1;
                end else begin
                    y <= 3'b011;
                    z <= 1'b1;
                end
            end
            
            default: begin
                y <= 3'b000;
                z <= 1'b0;
            end
        endcase
    end
end

endmodule

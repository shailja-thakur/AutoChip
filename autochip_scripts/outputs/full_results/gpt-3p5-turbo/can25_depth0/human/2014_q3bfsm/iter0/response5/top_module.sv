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
                    if (x == 1'b0) begin
                        y <= 3'b000;
                    end else begin
                        y <= 3'b001;
                    end
                end
                3'b001: begin
                    if (x == 1'b0) begin
                        y <= 3'b001;
                    end else begin
                        y <= 3'b100;
                    end
                end
                3'b010: begin
                    if (x == 1'b0) begin
                        y <= 3'b010;
                    end else begin
                        y <= 3'b001;
                    end
                end
                3'b011: begin
                    if (x == 1'b0) begin
                        y <= 3'b001;
                    end else begin
                        y <= 3'b010;
                    end
                end
                3'b100: begin
                    if (x == 1'b0) begin
                        y <= 3'b011;
                    end else begin
                        y <= 3'b100;
                    end
                end
                default: begin
                    y <= 3'b000;
                end
            endcase
        end
    end
    
    always @(posedge clk) begin
        case (y)
            3'b011: begin
                z <= 1'b1;
            end
            3'b100: begin
                z <= 1'b1;
            end
            default: begin
                z <= 1'b0;
            end
        endcase
    end
    
endmodule

module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

    reg [2:0] y_next;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            y_next <= 3'b000;
        end else begin
            case (y)    
                3'b000: begin
                    if (x) begin
                        y_next <= 3'b001;
                    else
                        y_next <= 3'b000;
                    end
                end
                3'b001: begin
                    if (x) begin
                        y_next <= 3'b100;
                    else
                        y_next <= 3'b001;
                    end
                end
                3'b010: begin
                    if (x) begin
                        y_next <= 3'b001;
                    else
                        y_next <= 3'b010;
                    end
                end
                3'b011: begin
                    if (x) begin
                        y_next <= 3'b010;
                        z <= 1;
                    else
                        y_next <= 3'b001;
                    end
                end
                3'b100: begin
                    if (x) begin
                        y_next <= 3'b100;
                        z <= 1;
                    else
                        y_next <= 3'b011;
                    end
                end
            endcase
        end 
    end

    reg [2:0] y;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            y <= 3'b000;
        end else begin
            y <= y_next;
        end
    end

endmodule

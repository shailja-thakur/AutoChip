module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

reg [5:0] y_reg;

// State flip-flop assignments
reg Y1FF;
reg Y3FF;

// Combinational logic for Y1 and Y3
always @(*) begin
    case (y[5:0])
        6'b000001: begin
            Y1FF = w;
            Y3FF = 1'b0;
        end
        
        6'b000010: begin
            Y1FF = w;
            Y3FF = 1'b0;
        end
        
        6'b000100: begin
            Y1FF = w;
            Y3FF = 1'b0;
        end
        
        6'b001000: begin
            Y1FF = w;
            Y3FF = 1'b0;
        end
        
        6'b010000: begin
            Y1FF = w;
            Y3FF = 1'b1;
        end
        
        6'b100000: begin
            Y1FF = w;
            Y3FF = 1'b1;
        end
        
        default: begin
            Y1FF = 1'b0;
            Y3FF = 1'b0;
        end
    endcase
end

// Register assignments
always @(posedge w) begin
    y_reg <= y;
end

// Output assignment
assign Y1 = Y1FF;
assign Y3 = Y3FF;

endmodule

module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

// Declare internal signals
reg Y1_reg;
reg Y3_reg;

// Assign Y1 and Y3 from y[1] and y[3] respectively
assign Y1 = y[1];
assign Y3 = y[3];

// Sequential process for updating Y1_reg and Y3_reg based on w and current state
always @(posedge w) begin
    case(y)
        6'b000001: begin // A
            Y1_reg <= 1'b0;
            Y3_reg <= 1'b0;
        end
        6'b000010: begin // B
            Y1_reg <= 1'b1;
            Y3_reg <= 1'b0;
        end
        6'b000100: begin // C
            Y1_reg <= 1'b1;
            Y3_reg <= 1'b1;
        end
        6'b001000: begin // D
            Y1_reg <= 1'b0;
            Y3_reg <= 1'b0;
        end
        6'b010000: begin // E
            Y1_reg <= 1'b0;
            Y3_reg <= 1'b1;
        end
        6'b100000: begin // F
            Y1_reg <= 1'b1;
            Y3_reg <= 1'b1;
        end
        default: begin // Invalid state
            Y1_reg <= 1'b0;
            Y3_reg <= 1'b0;
        end
    endcase
end

endmodule

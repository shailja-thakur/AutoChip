module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [1:0] state;
reg [23:0] shift_reg;
reg done;

always @(posedge clk) begin
    if (reset) begin
        state <= 2'b00;
        done <= 0;
    end else begin
        case (state)
            2'b00: begin
                if (in[3]) begin
                    state <= 2'b01;
                    shift_reg <= {in, shift_reg[15:0]};
                end else begin
                    shift_reg <= {shift_reg[7:0], 8'b0};
                end
            end
            
            2'b01: begin
                shift_reg <= {in, shift_reg[15:0]};
                state <= 2'b10;
            end
            
            2'b10: begin
                shift_reg <= {in, shift_reg[15:0]};
                state <= 2'b11;
            end
            
            2'b11: begin
                shift_reg <= {in, shift_reg[15:0]};
                done <= 1;
                state <= 2'b00;
            end
        endcase
    end
end

assign out_bytes = shift_reg;
endmodule

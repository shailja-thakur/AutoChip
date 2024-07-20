module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

reg [2:0] state;

always @(posedge clk) begin
    case(state)
        3'b000: begin
            if (x == 1) begin
                state <= 3'b001;
                Y0 <= 0;
            end else begin
                state <= 3'b000;
                Y0 <= 0;
            end
            z <= 0;
        end
        
        3'b001: begin
            if (x == 1) begin
                state <= 3'b100;
                Y0 <= 0;
            end else begin
                state <= 3'b001;
                Y0 <= 0;
            end
            z <= 0;
        end
        
        3'b010: begin
            if (x == 1) begin
                state <= 3'b001;
                Y0 <= 0;
            end else begin
                state <= 3'b010;
                Y0 <= 0;
            end
            z <= 0;
        end
        
        3'b011: begin
            if (x == 1) begin
                state <= 3'b010;
                Y0 <= 1;
            end else begin
                state <= 3'b001;
                Y0 <= 0;
            end
            z <= 1;
        end
        
        3'b100: begin
            if (x == 1) begin
                state <= 3'b100;
                Y0 <= 1;
            end else begin
                state <= 3'b011;
                Y0 <= 1;
            end
            z <= 1;
        end

        default: begin
            state <= 3'b000;
            Y0 <= 0;
            z <= 0;
        end
    endcase
end

endmodule

module top_module (
input clk,
input x,
input [2:0] y,
output reg Y0,
output reg z
);

reg [2:0] Y;

always @(posedge clk) begin
    case ({y, x})
        3'b000: begin
            Y <= 3'b000;
            Y0 <= Y[0];
            if (Y == 3'b000 || Y == 3'b001) begin
                z <= 1'b0;
            end else begin
                z <= 1'b1;
            end
        end
        
        3'b001: begin
            Y <= 3'b001;
            Y0 <= Y[0];
            if (Y == 3'b001 || Y == 3'b100) begin
                z <= 1'b0;
            end else begin
                z <= 1'b1;
            end
        end
        
        3'b010: begin
            Y <= 3'b010;
            Y0 <= Y[0];
            if (Y == 3'b010 || Y == 3'b001) begin
                z <= 1'b0;
            end else begin
                z <= 1'b1;
            end
        end
        
        3'b011: begin
            Y <= 3'b001;
            Y0 <= Y[0];
            if (Y == 3'b001 || Y == 3'b010) begin
                z <= 1'b1;
            end else begin
                z <= 1'b0;
            end
        end
        
        3'b100: begin
            Y <= 3'b011;
            Y0 <= Y[0];
            if (Y == 3'b011 || Y == 3'b100) begin
                z <= 1'b1;
            end else begin
                z <= 1'b0;
            end
        end
        
        default: begin
            Y <= 3'b000;
            z <= 1'b0;
        end
    endcase
end

endmodule

module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

always @(posedge clk) begin
    case(y)
        3'b000:
            begin
                if(x==0) begin
                    Y0 <= 0;
                    z <= 0;
                end
                else begin
                    Y0 <= 0;
                    z <= 1;
                end
            end
        
        3'b001:
            begin
                if(x==0) begin
                    Y0 <= 0;
                    z <= 0;
                end
                else begin
                    Y0 <= 1;
                    z <= 0;
                end
            end
            
        3'b010:
            begin
                if(x==0) begin
                    Y0 <= 0;
                    z <= 0;
                end
                else begin
                    Y0 <= 0;
                    z <= 1;
                end
            end
            
        3'b011:
            begin
                if(x==0) begin
                    Y0 <= 1;
                    z <= 0;
                end
                else begin
                    Y0 <= 0;
                    z <= 1;
                end
            end
            
        3'b100:
            begin
                if(x==0) begin
                    Y0 <= 1;
                    z <= 1;
                end
                else begin
                    Y0 <= 0;
                    z <= 0;
                end
            end
            
        default:
            begin
                Y0 <= 0;
                z <= 0;
            end
    endcase
end

endmodule

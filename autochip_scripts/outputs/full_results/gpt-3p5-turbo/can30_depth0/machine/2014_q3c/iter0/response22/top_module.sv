module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

    always_comb begin
        case ({y[2:0], x})
            4'h0: begin
                Y0 = 0;
            end
            4'h1: begin
                Y0 = 1;
            end
            4'h2: begin
                Y0 = 1;
            end
            4'h3: begin
                Y0 = 0;
            end
            4'h4: begin
                Y0 = 0;
            end
            4'h5: begin
                Y0 = 1;
            end
            4'h6: begin
                Y0 = 1;
            end
            4'h7: begin
                Y0 = 0;
            end
            4'h8: begin
                Y0 = 1;
            end
            4'h9: begin
                Y0 = 0;
            end
            default: begin
                Y0 = x;
            end
        endcase
        
        case (y[2:0])
            3'h0: begin
                z = 0;
            end
            3'h1: begin
                z = 0;
            end
            3'h2: begin
                z = 0;
            end
            3'h3: begin
                z = 1;
            end
            3'h4: begin
                z = 1;
            end
            default: begin
                z = x;
            end
        endcase
    end
endmodule

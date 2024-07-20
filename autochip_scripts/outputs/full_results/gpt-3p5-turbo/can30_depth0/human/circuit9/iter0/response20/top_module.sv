module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

always @(posedge clk) begin
    case(q)
        0: begin
            if(a)
                q <= 4;
        end
        4: begin
            if(a)
                q <= 5;
            else
                q <= 0;
        end
        5: begin
            if(a)
                q <= 6;
            else
                q <= 1;
        end
        6: begin
            if(a)
                q <= 0;
            else
                q <= 1;
        end
        default: begin
            q <= 0;
        end
    endcase
end

endmodule

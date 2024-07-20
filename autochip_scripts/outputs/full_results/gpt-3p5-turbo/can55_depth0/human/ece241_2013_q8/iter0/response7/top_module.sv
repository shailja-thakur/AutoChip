module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state;
reg q1, q2;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn)
        state <= 2'b00;
    else begin
        case (state)
            2'b00 : begin
                q1 <= x;
                if (q1 == 1'b1 && x == 1'b0)
                    state <= 2'b01;
                else
                    state <= 2'b00;
            end
            
            2'b01 : begin
                q2 <= x;
                if (q2 == 1'b0 && x == 1'b1)
                    state <= 2'b10;
                else
                    state <= 2'b00;
            end
            
            2'b10 : begin
                if (x == 1'b1)
                    state <= 2'b11;
                else
                    state <= 2'b00;
            end
            
            2'b11 : begin
                if (x == 1'b0)
                    state <= 2'b00;
                else begin
                    state <= 2'b11;
                    z <= 1'b1;
                end
            end
        endcase
    end
end

endmodule

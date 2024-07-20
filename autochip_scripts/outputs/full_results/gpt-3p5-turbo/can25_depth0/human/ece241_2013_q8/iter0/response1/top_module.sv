module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state;
reg r1, r2, r3;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= 2'b00;
        r1 <= 0;
        r2 <= 0;
        r3 <= 0;
        z <= 0;
    end
    else begin
        case (state)
            2'b00:
                if (x == 1'b1) begin
                    r1 <= 1;
                    state <= 2'b01;
                end
                else begin
                    r1 <= 0;
                end
            2'b01:
                if (x == 1'b0) begin
                    r2 <= 1;
                    state <= 2'b10;
                end
                else begin
                    r2 <= 0;
                    state <= 2'b00;
                end
            2'b10:
                if (x == 1'b1) begin
                    r3 <= 1;
                    state <= 2'b00;
                    z <= 1;
                end
                else begin
                    r3 <= 0;
                    state <= 2'b00;
                end
            default:
                state <= 2'b00;
        endcase
    end
end

endmodule

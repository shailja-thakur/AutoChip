module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state;
reg x_d1, x_d2;

always @(posedge clk or negedge aresetn) begin
    if (~aresetn)
        state <= 2'b00;
    else
        case (state)
            2'b00: begin
                if (x)
                    state <= 2'b01;
                else
                    state <= 2'b00;
            end
            2'b01: begin
                if (x)
                    state <= 2'b10;
                else
                    state <= 2'b00;
            end
            2'b10: begin
                if (x)
                    state <= 2'b11;
                else
                    state <= 2'b00;
            end
            2'b11: begin
                if (x)
                    state <= 2'b11;
                else
                    state <= 2'b00;
            end
            default: state <= 2'b00;
        endcase
    end
end

always @(posedge clk or negedge aresetn) begin
    if (~aresetn)
        z <= 1'b0;
    else begin
        x_d2 <= x_d1;
        x_d1 <= x;
        if (state == 2'b11 && ~x_d2 && ~x_d1)
            z <= 1'b1;
        else
            z <= 1'b0;
    end
end

endmodule

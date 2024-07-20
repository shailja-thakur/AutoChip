module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state;
always @(posedge clk or negedge aresetn) begin
    if (~aresetn)
        state <= 2'b00;
    else begin
        case (state)
            2'b00: begin
                if (x == 1'b1)
                    state <= 2'b01;
                else
                    state <= 2'b00;
            end
            2'b01: begin
                if (x == 1'b1)
                    state <= 2'b10;
                else
                    state <= 2'b00;
            end
            2'b10: begin
                if (x == 1'b1)
                    state <= 2'b00;
                else
                    state <= 2'b11;
            end
        endcase
    end
end

always @(state, x) begin
    case (state)
        2'b10: begin
            if (x == 1'b1)
                z <= 1'b1;
            else
                z <= 1'b0;
        end
        default: z <= 1'b0;
    endcase
end

endmodule

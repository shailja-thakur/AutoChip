module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= 2'b00;
    end else begin
        case (state)
            2'b00: begin // State S0
                if (x == 1'b1) begin
                    state <= 2'b01;
                end else begin
                    state <= 2'b00;
                end
            end
            2'b01: begin // State S1
                if (x == 1'b0) begin
                    state <= 2'b00;
                end else begin
                    state <= 2'b10;
                end
            end
            2'b10: begin // State S2
                if (x == 1'b1) begin
                    state <= 2'b01;
                    z <= 1'b1;
                end else begin
                    state <= 2'b00;
                    z <= 1'b0;
                end
            end
            default: state <= 2'b00;
        endcase
    end
end

endmodule

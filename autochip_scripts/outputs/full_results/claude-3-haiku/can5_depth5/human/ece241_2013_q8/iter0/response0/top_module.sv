module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state;
parameter IDLE = 2'b00, S1 = 2'b01, S101 = 2'b11;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= IDLE;
        z <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (x) begin
                    state <= S1;
                end
                z <= 1'b0;
            end
            S1: begin
                if (!x) begin
                    state <= IDLE;
                end
                else begin
                    state <= S101;
                end
                z <= 1'b0;
            end
            S101: begin
                if (x) begin
                    state <= S1;
                    z <= 1'b1;
                end
                else begin
                    state <= IDLE;
                    z <= 1'b0;
                end
            end
            default: begin
                state <= IDLE;
                z <= 1'b0;
            end
        endcase
    end
end

endmodule

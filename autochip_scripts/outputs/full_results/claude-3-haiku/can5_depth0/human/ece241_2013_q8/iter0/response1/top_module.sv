module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state;
localparam [1:0] IDLE = 2'b00, STATE1 = 2'b01, STATE2 = 2'b10;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= IDLE;
        z <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (x) begin
                    state <= STATE1;
                    z <= 1'b0;
                end
                else begin
                    state <= IDLE;
                    z <= 1'b0;
                end
            end
            STATE1: begin
                if (x) begin
                    state <= STATE2;
                    z <= 1'b0;
                end
                else begin
                    state <= IDLE;
                    z <= 1'b0;
                end
            end
            STATE2: begin
                if (x) begin
                    state <= STATE1;
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

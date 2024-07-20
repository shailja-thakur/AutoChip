module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

parameter STATE_A = 2'b00, STATE_B = 2'b01, STATE_C = 2'b10;
reg [1:0] current_state, next_state;

always @(negedge aresetn or posedge clk) begin
    if (!aresetn) begin
        current_state <= STATE_A;
        z <= 1'b0;
    end
    else begin
        current_state <= next_state;
        case (current_state)
            STATE_A: begin
                if (x) begin
                    next_state <= STATE_B;
                    z <= 1'b0;
                end
                else begin
                    next_state <= STATE_A;
                    z <= 1'b0;
                end
            end
            STATE_B: begin
                if (x) begin
                    next_state <= STATE_C;
                    z <= 1'b0;
                end
                else begin
                    next_state <= STATE_A;
                    z <= 1'b0;
                end
            end
            STATE_C: begin
                if (x) begin
                    next_state <= STATE_B;
                    z <= 1'b1;
                end
                else begin
                    next_state <= STATE_A;
                    z <= 1'b0;
                end
            end
            default: begin
                next_state <= STATE_A;
                z <= 1'b0;
            end
        endcase
    end
end

endmodule

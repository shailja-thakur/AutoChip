module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

localparam STATE_0 = 2'b00;
localparam STATE_1 = 2'b01;
localparam STATE_2 = 2'b10;

reg [1:0] current_state, next_state;

always @(posedge clk, negedge aresetn) begin
    if (!aresetn) begin
        current_state <= STATE_0;
        z <= 1'b0;
    end
    else begin
        current_state <= next_state;
        case (current_state)
            STATE_0: begin
                z <= 1'b0;
                if (x == 1'b1) begin
                    next_state <= STATE_1;
                end
                else begin
                    next_state <= STATE_0;
                end
            end
            STATE_1: begin
                z <= 1'b0;
                if (x == 1'b0) begin
                    next_state <= STATE_2;
                end
                else begin
                    next_state <= STATE_1;
                end
            end
            STATE_2: begin
                if (x == 1'b1) begin
                    z <= 1'b1;
                    next_state <= STATE_1;
                end
                else begin
                    z <= 1'b0;
                    next_state <= STATE_0;
                end
            end
            default: begin
                z <= 1'b0;
                next_state <= STATE_0;
            end
        endcase
    end
end

endmodule

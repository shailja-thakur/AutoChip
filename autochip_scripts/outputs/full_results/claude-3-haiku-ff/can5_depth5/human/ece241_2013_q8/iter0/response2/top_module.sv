module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

localparam [1:0] IDLE = 2'b00, STATE1 = 2'b01, STATE2 = 2'b10, STATE3 = 2'b11;
reg [1:0] state, next_state;

always @(posedge clk, negedge aresetn) begin
    if (!aresetn) begin
        state <= IDLE;
        z <= 1'b0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                z <= 1'b0;
                if (x) begin
                    next_state <= STATE1;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            STATE1: begin
                z <= 1'b0;
                if (x) begin
                    next_state <= STATE2;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            STATE2: begin
                z <= 1'b0;
                if (x) begin
                    next_state <= IDLE;
                    z <= 1'b1; // Assertion of output signal
                end
                else begin
                    next_state <= STATE3;
                end
            end
            STATE3: begin
                z <= 1'b0;
                if (x) begin
                    next_state <= STATE1;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            default: begin
                next_state <= IDLE;
            end
        endcase
    end
end

endmodule

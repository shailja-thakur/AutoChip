module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

localparam OFF = 1'b0;
localparam ON = 1'b1;

reg current_state, next_state;

always @(posedge clk) begin
    if (reset) begin
        current_state <= OFF;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        OFF: begin
            if (j) begin
                next_state = ON;
            end
            else begin
                next_state = OFF;
            end
            out = 1'b0;
        end
        ON: begin
            if (k) begin
                next_state = OFF;
            end
            else begin
                next_state = ON;
            end
            out = 1'b1;
        end
        default: begin
            next_state = OFF;
            out = 1'b0;
        end
    endcase
end

endmodule

module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

localparam OFF = 1'b0;
localparam ON = 1'b1;

reg state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= OFF;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        OFF: begin
            if (j) begin
                next_state = ON;
                out = 0;
            end
            else begin
                next_state = OFF;
                out = 0;
            end
        end
        ON: begin
            if (k) begin
                next_state = OFF;
                out = 1;
            end
            else begin
                next_state = ON;
                out = 1;
            end
        end
        default: begin
            next_state = OFF;
            out = 0;
        end
    endcase
end

endmodule

module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= 2'd0; // Reset to state A
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        2'd0: begin // State A
            next_state = in ? 2'd1 : 2'd0; // Next state B or A
            out = 1'b0;
        end
        2'd1: begin // State B
            next_state = in ? 2'd1 : 2'd2; // Next state B or C
            out = 1'b0;
        end
        2'd2: begin // State C
            next_state = in ? 2'd3 : 2'd0; // Next state D or A
            out = 1'b0;
        end
        2'd3: begin // State D
            next_state = in ? 2'd1 : 2'd2; // Next state B or C
            out = 1'b1;
        end
        default: begin
            next_state = 2'd0; // Reset to state A
            out = 1'b0;
        end
    endcase
end

endmodule

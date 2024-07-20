module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;
reg [1:0] w_count;

always @(posedge clk) begin
    if (reset) begin
        state <= 0; // State A
        w_count <= 0;
        z <= 0;
    end
    else begin
        case (state)
            0: // State A
                if (s) begin
                    state <= 1; // Transition to State B
                    w_count <= 0;
                end
            1: // State B
                if (w_count == 2) begin
                    z <= 1;
                end
                else begin
                    z <= 0;
                end
                w_count <= w_count + 1;
                if (w_count == 3) begin
                    state <= 0; // Transition back to State A
                    w_count <= 0;
                end
        endcase
    end
end

endmodule

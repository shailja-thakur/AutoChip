module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;
reg [1:0] count;

always @(posedge clk) begin
    if (reset) begin
        state <= 0;
        count <= 0;
        z <= 0;
    end
    else begin
        case (state)
            0: begin // State A
                if (s) begin
                    state <= 1;
                    count <= 0;
                end
            end
            1: begin // State B
                if (w) begin
                    count <= count + 1;
                end
                else begin
                    count <= 0;
                end
                if (count == 2) begin
                    z <= 1;
                end
                else begin
                    z <= 0;
                end
                if (count == 3) begin
                    state <= 1;
                    count <= 0;
                end
            end
        endcase
    end
end

endmodule

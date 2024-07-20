module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;
parameter A = 2'd0, B = 2'd1, C = 2'd2;

always @(posedge clk) begin
    if (reset) begin
        state <= A;
        z <= 1'b0;
    end
    else begin
        case (state)
            A: begin
                if (s) begin
                    state <= B;
                end
                else begin
                    state <= A;
                end
            end
            B: begin
                case ({state, w})
                    {B, 1'b1}: state <= C;
                    {B, 1'b0}: state <= B;
                endcase
            end
            C: begin
                case ({state, w})
                    {C, 1'b1}: begin
                        z <= 1'b1;
                        state <= B;
                    end
                    {C, 1'b0}: begin
                        z <= 1'b0;
                        state <= B;
                    end
                endcase
            end
        endcase
    end
end

endmodule

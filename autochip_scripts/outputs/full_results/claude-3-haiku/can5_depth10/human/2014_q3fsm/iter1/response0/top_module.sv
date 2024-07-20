module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;
parameter A = 2'b00, B = 2'b01, C = 2'b10;

reg [1:0] w_count;

always @(posedge clk) begin
    if (reset) begin
        state <= A;
        w_count <= 0;
        z <= 0;
    end
    else begin
        case (state)
            A: begin
                if (s) begin
                    state <= B;
                    w_count <= 0;
                end
                else begin
                    state <= A;
                    w_count <= 0;
                end
            end
            B: begin
                if (w) begin
                    w_count <= w_count + 1;
                end
                if (w_count == 2) begin
                    z <= 1;
                end
                else begin
                    z <= 0;
                end
                state <= C;
            end
            C: begin
                if (w) begin
                    w_count <= w_count + 1;
                end
                if (w_count == 2) begin
                    z <= 1;
                end
                else begin
                    z <= 0;
                end
                if (w_count == 2) begin
                    state <= A;
                    w_count <= 0;
                end
                else begin
                    state <= C;
                end
            end
        endcase
    end
end

endmodule

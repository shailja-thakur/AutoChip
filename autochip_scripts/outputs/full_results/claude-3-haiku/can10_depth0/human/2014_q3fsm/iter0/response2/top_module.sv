module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;
parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

reg [1:0] count;

always @(posedge clk) begin
    if (reset) begin
        state <= A;
        count <= 0;
        z <= 0;
    end
    else begin
        case (state)
            A: begin
                if (s) begin
                    state <= B;
                    count <= 0;
                end
            end
            B: begin
                count <= count + 1;
                if (count == 2) begin
                    if (w) begin
                        state <= C;
                    end
                    else begin
                        state <= D;
                    end
                    count <= 0;
                end
            end
            C: begin
                z <= 1;
                state <= B;
            end
            D: begin
                z <= 0;
                state <= B;
            end
        endcase
    end
end

endmodule

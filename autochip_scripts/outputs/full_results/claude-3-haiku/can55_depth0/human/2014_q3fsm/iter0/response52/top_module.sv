module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;
parameter A = 2'b00, B = 2'b01, C = 2'b10;

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
                if (s) state <= B;
                else state <= A;
                count <= 0;
            end
            B: begin
                if (w) count <= count + 1;
                if (count == 2) begin
                    z <= 1;
                    state <= C;
                end
                else state <= B;
            end
            C: begin
                if (w) count <= count + 1;
                if (count == 2) begin
                    z <= 1;
                    state <= B;
                end
                else begin
                    z <= 0;
                    state <= B;
                end
            end
        endcase
    end
end

endmodule

module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;
reg [1:0] count;

localparam A = 2'b00, B = 2'b01, C = 2'b10;

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
                if (count == 2'b10) begin
                    z <= 1;
                    state <= C;
                end
                else state <= B;
            end
            C: begin
                if (w) count <= count + 1;
                if (count == 2'b10) begin
                    z <= 0;
                    state <= B;
                end
                else state <= C;
            end
        endcase
    end
end

endmodule

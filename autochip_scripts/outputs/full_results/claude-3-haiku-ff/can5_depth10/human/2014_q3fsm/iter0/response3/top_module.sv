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
                if (s) begin
                    state <= B;
                    count <= 0;
                end
                else begin
                    state <= A;
                    count <= 0;
                end
            end
            B: begin
                if (w) begin
                    count <= count + 1;
                end
                if (count == 2) begin
                    state <= C;
                    z <= 1;
                end
                else if (count == 3) begin
                    state <= B;
                    count <= 0;
                    z <= 0;
                end
            end
            C: begin
                if (w) begin
                    count <= count + 1;
                end
                if (count == 2) begin
                    state <= B;
                    z <= 1;
                end
                else if (count == 3) begin
                    state <= B;
                    count <= 0;
                    z <= 0;
                end
            end
        endcase
    end
end

endmodule

module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;
reg [1:0] count;

parameter A = 2'd0, B = 2'd1, C = 2'd2;

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
                count <= count + 1;
                if (count == 2'd2) begin
                    if (w) begin
                        z <= 1;
                    end
                    else begin
                        z <= 0;
                    end
                    state <= C;
                    count <= 0;
                end
                else begin
                    state <= B;
                end
            end
            C: begin
                count <= count + 1;
                if (count == 2'd2) begin
                    state <= B;
                    count <= 0;
                end
                else begin
                    state <= C;
                end
            end
            default: begin
                state <= A;
                count <= 0;
                z <= 0;
            end
        endcase
    end
end

endmodule

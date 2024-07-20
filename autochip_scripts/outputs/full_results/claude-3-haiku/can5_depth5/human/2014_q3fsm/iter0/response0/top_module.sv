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
                if (count == 2'b11) begin
                    if (w) begin
                        z <= 1;
                    end
                    else begin
                        z <= 0;
                    end
                    state <= A;
                    count <= 0;
                end
                else begin
                    count <= count + 1;
                    state <= B;
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

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
        count <= 2'b00;
        z <= 1'b0;
    end
    else begin
        case (state)
            A: begin
                if (s == 1'b1) begin
                    state <= B;
                    count <= 2'b00;
                end
            end
            B: begin
                if (w == 1'b1) begin
                    count <= count + 1'b1;
                end
                if (count == 2'b10) begin
                    state <= C;
                    z <= 1'b1;
                end
                else if (count == 2'b11) begin
                    state <= A;
                    z <= 1'b0;
                    count <= 2'b00;
                end
            end
            C: begin
                if (w == 1'b1) begin
                    count <= count + 1'b1;
                end
                if (count == 2'b10) begin
                    state <= A;
                    z <= 1'b0;
                    count <= 2'b00;
                end
            end
        endcase
    end
end

endmodule

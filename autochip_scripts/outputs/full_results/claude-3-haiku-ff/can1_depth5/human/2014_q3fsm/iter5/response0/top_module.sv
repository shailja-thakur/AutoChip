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
reg [1:0] wcount;

always @(posedge clk) begin
    if (reset) begin
        state <= A;
        count <= 0;
        wcount <= 0;
        z <= 0;
    end
    else begin
        case (state)
            A: begin
                if (s) begin
                    state <= B;
                    count <= 0;
                    wcount <= 0;
                end
                else begin
                    state <= A;
                    count <= 0;
                    wcount <= 0;
                    z <= 0;
                end
            end
            B: begin
                if (w) begin
                    wcount <= wcount + 1;
                end
                count <= count + 1;
                if (count == 2'b11) begin
                    if (wcount == 2) begin
                        z <= 1;
                    end
                    else begin
                        z <= 0;
                    end
                    state <= C;
                    count <= 0;
                    wcount <= 0;
                end
            end
            C: begin
                count <= count + 1;
                if (count == 2'b11) begin
                    state <= B;
                    count <= 0;
                end
            end
        endcase
    end
end

endmodule

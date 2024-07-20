module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;
reg [1:0] count;
reg w_prev;
reg [1:0] w_count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00;
        count <= 2'b00;
        w_prev <= 0;
        w_count <= 2'b00;
        z <= 0;
    end else begin
        case (state)
            2'b00: begin
                if (s) begin
                    state <= 2'b01;
                end
            end
            2'b01: begin
                if (w) begin
                    w_count <= w_count + 1;
                end
                state <= 2'b11;
            end
            2'b11: begin
                if (w) begin
                    w_count <= w_count + 1;
                end
                if (count == 2'b10) begin
                    z <= 1;
                end else begin
                    z <= 0;
                end
                state <= 2'b00;
                count <= 2'b00;
                w_count <= 2'b00;
            end
        endcase
    end
    w_prev <= w;
    if (w_count == 2'b10 && w_prev) begin
        count <= count + 1;
    end
end

endmodule

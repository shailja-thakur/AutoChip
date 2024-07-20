module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

localparam STATE_A = 2'b00;
localparam STATE_B = 2'b01;
localparam STATE_C = 2'b10;

reg [1:0] state;
reg [1:0] w_count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= STATE_A;
        w_count <= 2'b00;
        z <= 1'b0;
    end
    else begin
        case (state)
            STATE_A: begin
                if (s == 1'b1) begin
                    state <= STATE_B;
                    w_count <= 2'b00;
                end
            end
            STATE_B: begin
                w_count <= w_count + (w == 1'b1);
                if (w_count == 2'b10) begin
                    state <= STATE_C;
                    z <= 1'b1;
                end
                else if (w_count == 2'b11) begin
                    state <= STATE_A;
                    z <= 1'b0;
                end
            end
            STATE_C: begin
                state <= STATE_A;
                z <= 1'b0;
            end
            default: begin
                state <= STATE_A;
                w_count <= 2'b00;
                z <= 1'b0;
            end
        endcase
    end
end

endmodule

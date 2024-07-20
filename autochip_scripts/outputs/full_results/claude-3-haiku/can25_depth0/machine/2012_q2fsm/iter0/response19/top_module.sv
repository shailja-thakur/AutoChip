module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state;

localparam STATE_A = 3'b000;
localparam STATE_B = 3'b001;
localparam STATE_C = 3'b010;
localparam STATE_D = 3'b011;
localparam STATE_E = 3'b100;
localparam STATE_F = 3'b101;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= STATE_A;
    end
    else begin
        case (state)
            STATE_A: begin
                if (w == 1'b0) begin
                    state <= STATE_A;
                end
                else begin
                    state <= STATE_B;
                end
            end
            STATE_B: begin
                if (w == 1'b0) begin
                    state <= STATE_D;
                end
                else begin
                    state <= STATE_C;
                end
            end
            STATE_C: begin
                if (w == 1'b0) begin
                    state <= STATE_D;
                end
                else begin
                    state <= STATE_E;
                end
            end
            STATE_D: begin
                if (w == 1'b0) begin
                    state <= STATE_A;
                end
                else begin
                    state <= STATE_F;
                end
            end
            STATE_E: begin
                if (w == 1'b0) begin
                    state <= STATE_D;
                end
                else begin
                    state <= STATE_E;
                end
            end
            STATE_F: begin
                if (w == 1'b0) begin
                    state <= STATE_D;
                end
                else begin
                    state <= STATE_C;
                end
            end
            default: begin
                state <= STATE_A;
            end
        endcase
    end
end

always @(*) begin
    if (state == STATE_E || state == STATE_F) begin
        z = 1'b1;
    end
    else begin
        z = 1'b0;
    end
end

endmodule

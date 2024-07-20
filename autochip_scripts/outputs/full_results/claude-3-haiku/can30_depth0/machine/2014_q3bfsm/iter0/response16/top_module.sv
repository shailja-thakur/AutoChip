module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] state;
localparam STATE_A = 3'b000, STATE_B = 3'b001, STATE_C = 3'b010, STATE_D = 3'b011, STATE_E = 3'b100;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= STATE_A;
    end
    else begin
        case (state)
            STATE_A: begin
                if (x) begin
                    state <= STATE_B;
                end
                else begin
                    state <= STATE_A;
                end
            end
            STATE_B: begin
                if (x) begin
                    state <= STATE_E;
                end
                else begin
                    state <= STATE_B;
                end
            end
            STATE_C: begin
                if (x) begin
                    state <= STATE_B;
                end
                else begin
                    state <= STATE_C;
                end
            end
            STATE_D: begin
                if (x) begin
                    state <= STATE_C;
                end
                else begin
                    state <= STATE_B;
                end
            end
            STATE_E: begin
                if (x) begin
                    state <= STATE_E;
                end
                else begin
                    state <= STATE_D;
                end
            end
            default: begin
                state <= STATE_A;
            end
        endcase
    end
end

always @(*) begin
    case (state)
        STATE_D, STATE_E: z = 1'b1;
        default: z = 1'b0;
    endcase
end

endmodule

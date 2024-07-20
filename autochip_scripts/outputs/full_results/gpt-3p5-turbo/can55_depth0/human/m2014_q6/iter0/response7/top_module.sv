module top_module (
    input clk,
    input reset,
    input w,
    output z
);

reg [2:0] state;
reg z;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'd0;
    else begin
        case(state)
            3'd0: begin
                if (w) state <= 3'd0;
                else state <= 3'd1;
            end
            3'd1: begin
                if (w) state <= 3'd3;
                else state <= 3'd2;
            end
            3'd2: begin
                if (w) state <= 3'd1;
                else state <= 3'd3;
            end
            3'd3: begin
                if (w) state <= 3'd5;
                else state <= 3'd4;
            end
            3'd4: begin
                if (w) state <= 3'd2;
                else state <= 3'd3;
            end
            3'd5: begin
                if (w) state <= 3'd5;
                else state <= 3'd4;
            end
        endcase
    end
end

always @(state) begin
    case(state)
        3'd0: z = 1'b0;
        3'd1: z = 1'b1;
        3'd2: z = 1'b0;
        3'd3: z = 1'b1;
        3'd4: z = 1'b1;
        3'd5: z = 1'b0;
    endcase
end

endmodule

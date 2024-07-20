module top_module(
    input x,
    input y,
    output reg z
);

reg [2:0] state;

always @(*) begin
    case (state)
        3'd0: z = 1'b1;
        3'd1: z = 1'b0;
        3'd2: z = 1'b0;
        3'd3: z = 1'b1;
        3'd4: z = 1'b1;
        3'd5: z = 1'b0;
        3'd6: z = 1'b0;
        3'd7: z = 1'b0;
    endcase
end

always @(posedge x or posedge y) begin
    if (x) begin
        case (state)
            3'd0: state <= 3'd1;
            3'd1: state <= 3'd4;
            3'd2: state <= 3'd5;
            3'd3: state <= 3'd6;
            3'd4: state <= 3'd7;
            3'd5: state <= 3'd0;
            3'd6: state <= 3'd2;
            3'd7: state <= 3'd3;
        endcase
    end
    else if (y) begin
        case (state)
            3'd0: state <= 3'd2;
            3'd1: state <= 3'd3;
            3'd2: state <= 3'd0;
            3'd3: state <= 3'd1;
            3'd4: state <= 3'd4;
            3'd5: state <= 3'd6;
            3'd6: state <= 3'd7;
            3'd7: state <= 3'd5;
        endcase
    end
end

endmodule

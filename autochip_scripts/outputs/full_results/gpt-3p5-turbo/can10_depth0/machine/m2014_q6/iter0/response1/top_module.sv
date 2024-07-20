module top_module (
    input clk,
    input reset,
    input w,
    output z
);

    reg [2:0] state;
    reg z;

    always @(posedge clk) begin
        if (reset)
            state <= 3'd0;
        else begin
            case (state)
                3'd0: if (w) state <= 3'd0; else state <= 3'd1;
                3'd1: if (w) state <= 3'd3; else state <= 3'd2;
                3'd2: if (w) state <= 3'd3; else state <= 3'd4;
                3'd3: if (w) state <= 3'd0; else state <= 3'd5;
                3'd4: if (w) state <= 3'd3; else state <= 3'd4;
                3'd5: if (w) state <= 3'd3; else state <= 3'd2;
                default: state <= 3'd0;
            endcase
        end
    end

    always @(state) begin
        if (state == 3'd4 || state == 3'd5)
            z = 1'b1;
        else
            z = 1'b0;
    end

endmodule

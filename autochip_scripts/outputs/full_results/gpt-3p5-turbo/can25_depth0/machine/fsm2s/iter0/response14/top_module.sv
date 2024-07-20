module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);

    reg [1:0] state;
    always @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            state <= 2'b0;
        end else begin
            case(state)
                2'b0: begin
                    if (j == 1'b1) begin
                        state <= 2'b1;
                    end else begin
                        state <= 2'b0;
                    end
                end
                2'b1: begin
                    if (k == 1'b1) begin
                        state <= 2'b0;
                    end else begin
                        state <= 2'b1;
                    end
                end
                default: begin
                    state <= 2'b0;
                end
            endcase
        end
    end

    assign out = (state == 2'b1) ? 1'b1 : 1'b0;

endmodule

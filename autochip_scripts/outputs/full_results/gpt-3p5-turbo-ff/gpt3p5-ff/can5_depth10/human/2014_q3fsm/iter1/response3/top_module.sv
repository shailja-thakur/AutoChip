module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    reg [1:0] state;
    reg [2:0] w_count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            w_count <= 0;
            z <= 0;
        end else begin
            case (state)
                0: begin
                    if (s == 1)
                        state <= 1;
                end
                1: begin
                    w_count <= w_count + 1;
                    if (w_count == 3) begin
                        if (w_count[2:0] == 2'b11)
                            z <= 1;
                        else
                            z <= 0;
                        w_count <= 0;
                        state <= 0;
                    end
                end
            endcase
        end
    end
endmodule
